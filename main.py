import cv2 as cv
import mediapipe as mp
import pyautogui as pag
from enum import Enum


class HAND_POSE(Enum):
    START = -1
    STOP = -2
    CLICK = 0
    UP = 1
    RIGHT = 2
    DOWN = 3
    LEFT = 4
    OTHER = 99


def checkClick(landmarks):
    if (all([
        *(landmarks[i].y < landmarks[i + 3].y for i in range(5, 18, 4)),
        *(landmarks[i].y < landmarks[3].y for i in range(6, 19, 4)),
        *(landmarks[i].y < landmarks[0].y for i in range(2, 21)),
    ])):
        return True
    return False


def checkUp(landmarks):
    if (all([
        *(landmarks[i].y < landmarks[i + 3].y for i in range(9, 18, 4)),
        *(landmarks[i].y > landmarks[8].y for i in range(0, 21) if i != 8),
        *(landmarks[i].y < landmarks[0].y for i in range(2, 21)),
    ])):
        return True
    return False


def checkDown(landmarks):
    if (all([
        *(landmarks[i].y > landmarks[12].y for i in range(9, 12)),
        *(landmarks[i].y > landmarks[16].y for i in range(13, 16)),
        *(landmarks[i].y > landmarks[20].y for i in range(17, 20)),
        *(landmarks[i].y < landmarks[0].y for i in range(2, 21)),
        abs(landmarks[4].y - landmarks[8].y) < 0.05,
        abs(landmarks[4].x - landmarks[8].x) < 0.05,
    ])):
        return True
    return False


def checkLeft(landmarks):
    if (all([
        *(landmarks[i].x > landmarks[0].x for i in range(2, 21)),
        *(landmarks[i].x > landmarks[1].x for i in range(2, 21)),
        *(landmarks[i].x < landmarks[8].x for i in range(0, 21) if i != 8)
    ])):
        return True
    return False


def checkRight(landmarks):
    if (all([
        *(landmarks[i].x < landmarks[1].x for i in range(3, 21)),
        *(landmarks[i].x < landmarks[2].x for i in range(3, 21)),
        *(landmarks[i].x > landmarks[8].x for i in range(0, 21) if i != 8)
    ])):
        return True
    return False


def getHandPose(hand_landmarks):
    landmarks = hand_landmarks.landmark
    if (checkClick(landmarks)):
        return HAND_POSE.CLICK
    # if (checkUp(landmarks)):
    #     return HAND_POSE.UP
    if (checkDown(landmarks)):
        return HAND_POSE.DOWN
    if (checkLeft(landmarks)):
        return HAND_POSE.LEFT
    if (checkRight(landmarks)):
        return HAND_POSE.RIGHT
    return HAND_POSE.OTHER


mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
mp_hands = mp.solutions.hands


def getHandMove(pose):
    if (pose == HAND_POSE.CLICK):
        return 'rotate'
    if (pose == HAND_POSE.DOWN):
        return 'speed'
    if (pose == HAND_POSE.LEFT):
        return 'left'
    if (pose == HAND_POSE.RIGHT):
        return 'right'
    else:
        return 'idle'


def triggerMove(pose):
    if (pose == HAND_POSE.CLICK):
        pag.press('up')
    if (pose == HAND_POSE.DOWN):
        pag.press('space')
    if (pose == HAND_POSE.LEFT):
        pag.press('left')
    if (pose == HAND_POSE.RIGHT):
        pag.press('right')


win_name = 'hand_tracker'
win_width = 400
win_height = 300
vid = cv.VideoCapture(0)
clock = 0
player_move = None

with mp_hands.Hands(
    model_complexity=0,
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5
) as hands:
    cv.namedWindow(win_name)
    cv.moveWindow(win_name, 0, 0)
    while True:
        ret, frame = vid.read()
        if not ret or frame is None:
            break

        frame = cv.cvtColor(frame, cv.COLOR_BGR2RGB)

        results = hands.process(frame)

        frame = cv.cvtColor(frame, cv.COLOR_RGB2BGR)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                mp_drawing.draw_landmarks(
                    frame,
                    hand_landmarks,
                    mp_hands.HAND_CONNECTIONS,
                    mp_drawing_styles.get_default_hand_landmarks_style(),
                    mp_drawing_styles.get_default_hand_connections_style()
                )

        frame = cv.flip(frame, 1)
        frame = cv.resize(frame, (win_width, win_height))

        hls = results.multi_hand_landmarks
        if hls:
            pose = getHandPose(hls[0])
            player_move = getHandMove(pose)

            if clock >= 8 and pose != HAND_POSE.OTHER:
                triggerMove(pose)
                clock = 0

        cv.putText(frame, f"Clock: {clock}", (20, 50),
                   cv.FONT_HERSHEY_PLAIN, 2, (215, 78, 9), 2, cv.LINE_AA)
        cv.putText(frame, f"Pose: {player_move}", (20, 80),
                   cv.FONT_HERSHEY_PLAIN, 2, (215, 78, 9), 2, cv.LINE_AA)
        cv.imshow(win_name, frame)

        clock = clock + 1
        if cv.waitKey(1) & 0xFF == ord('q'):
            break

vid.release()
cv.destroyAllWindows()

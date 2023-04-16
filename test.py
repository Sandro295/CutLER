import cv2
import configparser

def show_diff(image1, image2, output_name: str):
    # load images
    # image1 = cv2.imread("leftImage.jpg")
    # image2 = cv2.imread("rightImage.jpg")

    # compute difference
    difference = cv2.subtract(image1, image2)

    # color the mask red
    Conv_hsv_Gray = cv2.cvtColor(difference, cv2.COLOR_BGR2GRAY)
    _, mask = cv2.threshold(Conv_hsv_Gray, 0, 255,cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)
    difference[mask != 255] = [0, 0, 255]

    # add the red mask to the images to make the differences obvious
    image1[mask != 255] = [0, 0, 255]
    image2[mask != 255] = [0, 0, 255]

    # store images
    cv2.imwrite(output_name, difference)

def main():
    config = configparser.ConfigParser()

    config.read_file(open(r'testcfg.ini'))
    reference = config.get('jpeg_paths', 'ref_difference')
    output1 =   config.get('jpeg_paths', 'output1')
    output2 =   config.get('jpeg_paths', 'output2')
    your_diff_name = 'your_diff.jpg'

    image1 = cv2.imread(output1)
    image2 = cv2.imread(output2)

    show_diff(image1, image2, your_diff_name)

    image_ref_diff = cv2.imread(reference)
    your_diff = cv2.imread(your_diff_name)
    mask1 = cv2.threshold(image_ref_diff, 0, 255, cv2.THRESH_BINARY)[1]
    mask2 = cv2.threshold(your_diff, 0, 255, cv2.THRESH_BINARY)[1]


    difference = cv2.subtract(mask1, mask2)[1]

    # final_diff = cv2.countNonZero(difference)

    if difference.max() == 0:
        print("Test passed")
    else:
        print("Test failed")

if __name__ == "__main__":
    main()

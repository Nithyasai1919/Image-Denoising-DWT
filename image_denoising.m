clc;
clear;
close all;

% 1. Load image
img = imread('cameraman.tif');
img = im2double(img);

% 2. Add noise
noisy_img = imnoise(img, 'gaussian', 0, 0.01);

% 3. Apply DWT
[LL, LH, HL, HH] = dwt2(noisy_img, 'haar');

% 4. Reduce noise (threshold)
threshold = 0.15;

LH = wthresh(LH, 's', threshold);
HL = wthresh(HL, 's', threshold);
HH = wthresh(HH, 's', threshold);

% 5. Reconstruct image
denoised_img = idwt2(LL, LH, HL, HH, 'haar');

% 6. Show output
figure;
subplot(1,3,1); imshow(img); title('Original');
subplot(1,3,2); imshow(noisy_img); title('Noisy');
subplot(1,3,3); imshow(denoised_img); title('Denoised');
mse = mean((img(:) - denoised_img(:)).^2);
psnr = 10 * log10(1 / mse);

disp(['MSE: ', num2str(mse)]);
disp(['PSNR: ', num2str(psnr)]);
figure;
subplot(2,2,1); imshow(LL,[]); title('LL');
subplot(2,2,2); imshow(LH,[]); title('LH');
subplot(2,2,3); imshow(HL,[]); title('HL');
subplot(2,2,4); imshow(HH,[]); title('HH');
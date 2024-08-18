const wristbandNumberMinLength = 6;
const wristbandNumberMaxLength = 16;

bool numberValid(String number) {
  return number.length >= wristbandNumberMinLength &&
      number.length <= wristbandNumberMaxLength;
}

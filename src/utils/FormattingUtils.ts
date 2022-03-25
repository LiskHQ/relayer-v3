import { ethers, BigNumber } from "ethers";

export const toWei = (num: string | number | BigNumber) => ethers.utils.parseEther(num.toString());

export const toBNWei = (num: string | number | BigNumber) => BigNumber.from(toWei(num));

export const fromWei = (num: string | number | BigNumber) => ethers.utils.formatUnits(num.toString());

export const toBN = (num: string | number | BigNumber) => {
  // If the string version of the num contains a `.` then it is a number which needs to be parsed to a string int.
  if (num.toString().includes(".")) return BigNumber.from(parseInt(num.toString()));
  return BigNumber.from(num.toString());
};
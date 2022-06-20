import { helper } from '@ember/component/helper';

export function formatDate(params) {
  // formatting date to look cool
  let string = String(params[0])
  let list = string.split(' ');
  let date = list[2];
  let month = list[1];
  let year = list[3];
  
  return date + " " + month + " " + year;
}

export default helper(formatDate);

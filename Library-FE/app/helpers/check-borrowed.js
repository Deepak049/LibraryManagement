import { helper } from '@ember/component/helper';

export function checkBorrowed(params) {
  // checks if the user has exceeded the borrowing limit
  let borrowLimit = 2;
  let allowToBorrow = false;
  let orders = params[0];

  if(orders.length < borrowLimit){
    allowToBorrow = true; 
  }

  // returns boolean whether the user can borrow book or not
  return allowToBorrow;
}

export default helper(checkBorrowed);

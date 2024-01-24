import Debug "mo:base/Debug";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{

  // Orthogonal persistence for the bank balance and start time.
  stable var currentValue: Float = 300;
  stable var startTime = Time.now();

  // Uncomment to reset the bank balance and start time.
  // currentValue := 300;
  // startTime := Time.now();
  // Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(startTime));

  let interestRate: Float = 1.01;

  Debug.print(debug_show(startTime));

  // Top up the account with the given amount.
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // Withdraws the given amount from the account.
  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if(tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print(debug_show("Amount too large, currentValue less than zero!"));
    }
  };

  // Returns the current balance of the account. Fast query.
  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (interestRate ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
}
from math import gcd
def solution(numer1, denom1, numer2, denom2):
    lcm = denom1 * denom2 // gcd(denom1, denom2)
    new_numer = numer1 * (lcm // denom1) + numer2 * (lcm // denom2)
    common_divisor = gcd(new_numer, lcm)
    return [new_numer // common_divisor, lcm // common_divisor]
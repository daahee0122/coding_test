import math

def solution(n):
    slices_per_pizza = 6
    lcm = (slices_per_pizza * n) // math.gcd(slices_per_pizza, n)
    return lcm // slices_per_pizza

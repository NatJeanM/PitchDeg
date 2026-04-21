import random
from collections import Counter

items = [
    "rising_1", "rising_flat_1", "rising_falling_1", "flat_rising_1", "flat_1",
    "flat_falling_1", "falling_rising_1", "falling_flat_1", "falling_1",
    "rising_3", "rising_flat_3", "rising_falling_3", "flat_rising_3", "flat_3",
    "flat_falling_3", "falling_rising_3", "falling_flat_3", "falling_3",
    "rising_5", "rising_flat_5", "rising_falling_5", "flat_rising_5", "flat_5",
    "flat_falling_5", "falling_rising_5", "falling_flat_5", "falling_5"
]

def category(x):
    # everything before the final underscore-number
    return x.rsplit("_", 1)[0]

pool = items * 4

while True:
    random.shuffle(pool)

    if all(category(a) != category(b) for a, b in zip(pool, pool[1:])):
        break

# safety checks
assert Counter(pool) == Counter(items * 4)
assert all(category(a) != category(b) for a, b in zip(pool, pool[1:]))

# exact formatting
for item in pool:
    print(f'"{item}"   ""')

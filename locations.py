from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import ItemClassification, Location

from . import items

if TYPE_CHECKING:
    from .world import ArchipelanoWorld

# Every location must have a unique integer ID associated with it.
# We will have a lookup from location name to ID here that, in world.py, we will import and bind to the world class.
# Even if a location doesn't exist on specific options, it must be present in this lookup.
LOCATION_NAME_TO_ID = {
    "Door_1": 1,
    "Door_2": 2,
    "Door_3": 3,
    "Door_4": 4,
    "Door_5": 5,
    "Door_6": 6,
    "Door_7": 7,
    "Door_8": 8,
    "Door_9": 9,
    "Door_10": 10,
    "Key_1": 101,
    "Key_2": 102,
    "Key_3": 103,
    "Key_4": 104,
    "Key_5": 105,
    "Key_6": 106,
    "Key_7": 107,
    "Key_8": 108,
    "Key_9": 109,
    "Key_10": 110,
}


# Each Location instance must correctly report the "game" it belongs to.
# To make this simple, it is common practice to subclass the basic Location class and override the "game" field.
class ArchipelanoLocation(Location):
    game = "Archipelano"


# Let's make one more helper method before we begin actually creating locations.
# Later on in the code, we'll want specific subsections of LOCATION_NAME_TO_ID.
# To reduce the chance of copy-paste errors writing something like {"Chest": LOCATION_NAME_TO_ID["Chest"]},
# let's make a helper method that takes a list of location names and returns them as a dict with their IDs.
# Note: There is a minor typing quirk here. Some functions want location addresses to be an "int | None",
# so while our function here only ever returns dict[str, int], we annotate it as dict[str, int | None].
def get_location_names_with_ids(location_names: list[str]) -> dict[str, int | None]:
    return {location_name: LOCATION_NAME_TO_ID[location_name] for location_name in location_names}


def create_all_locations(world: ArchipelanoWorld) -> None:
    create_regular_locations(world)
    create_events(world)


def create_regular_locations(world: ArchipelanoWorld) -> None:
    # Finally, we need to put the Locations ("checks") into their regions.
    # Once again, before we do anything, we can grab our regions we created by using world.get_region()
    level_1 = world.get_region("level_1")
    level_2 = world.get_region("level_2")
    level_3 = world.get_region("level_3")
    level_4 = world.get_region("level_4")
    level_5 = world.get_region("level_5")
    level_6 = world.get_region("level_6")
    level_7 = world.get_region("level_7")
    level_8 = world.get_region("level_8")
    level_9 = world.get_region("level_9")
    level_10 = world.get_region("level_10")

    # A simpler way to do this is by using the region.add_locations helper.
    # For this, you need to have a dict of location names to their IDs (i.e. a subset of location_name_to_id)
    # Aha! So that's why we made that "get_location_names_with_ids" helper method earlier.
    # You also need to pass your overridden Location class.
    level_1_locations = get_location_names_with_ids(
        ["Door_1", "Key_1"]
    )
    level_1.add_locations(level_1_locations, ArchipelanoLocation)
    level_2_locations = get_location_names_with_ids(
        ["Door_2", "Key_2"]
    )
    level_2.add_locations(level_2_locations, ArchipelanoLocation)
    level_3_locations = get_location_names_with_ids(
        ["Door_3", "Key_3"]
    )
    level_3.add_locations(level_3_locations, ArchipelanoLocation)
    level_4_locations = get_location_names_with_ids(
        ["Door_4", "Key_4"]
    )
    level_4.add_locations(level_4_locations, ArchipelanoLocation)
    level_5_locations = get_location_names_with_ids(
        ["Door_5", "Key_5"]
    )
    level_5.add_locations(level_5_locations, ArchipelanoLocation)
    level_6_locations = get_location_names_with_ids(
        ["Door_6", "Key_6"]
    )
    level_6.add_locations(level_6_locations, ArchipelanoLocation)
    level_7_locations = get_location_names_with_ids(
        ["Door_7", "Key_7"]
    )
    level_7.add_locations(level_7_locations, ArchipelanoLocation)
    level_8_locations = get_location_names_with_ids(
        ["Door_8", "Key_8"]
    )
    level_8.add_locations(level_8_locations, ArchipelanoLocation)
    level_9_locations = get_location_names_with_ids(
        ["Door_9", "Key_9"]
    )
    level_9.add_locations(level_9_locations, ArchipelanoLocation)
    level_10_locations = get_location_names_with_ids(
        ["Door_10", "Key_10"]
    )
    level_10.add_locations(level_10_locations, ArchipelanoLocation)

def create_events(world: ArchipelanoWorld) -> None:
     level_10.add_event(
        "YOU WIN", "Victory", location_type=ArchipelanoLocation, item_type=items.ArchipelanoItem
    )
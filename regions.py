from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Entrance, Region

if TYPE_CHECKING:
    from .world import ArchipelanoWorld

# A region is a container for locations ("checks"), which connects to other regions via "Entrance" objects.
# Many games will model their Regions after physical in-game places, but you can also have more abstract regions.
# For a location to be in logic, its containing region must be reachable.
# The Entrances connecting regions can have rules - more on that in rules.py.
# This makes regions especially useful for traversal logic ("Can the player reach this part of the map?")

# Every location must be inside a region, and you must have at least one region.
# This is why we create regions first, and then later we create the locations (in locations.py).


def create_and_connect_regions(world: ArchipelanoWorld) -> None:
    create_all_regions(world)
    connect_regions(world)


def create_all_regions(world: Archipelano) -> None:
    # Creating a region is as simple as calling the constructor of the Region class.
    level_1 = Region("level_1", world.player, world.multiworld)
    level_2 = Region("level_2", world.player, world.multiworld)
    level_3 = Region("level_3", world.player, world.multiworld)
    level_4 = Region("level_4", world.player, world.multiworld)
    level_5 = Region("level_5", world.player, world.multiworld)
    level_6 = Region("level_6", world.player, world.multiworld)
    level_7 = Region("level_7", world.player, world.multiworld)
    level_8 = Region("level_8", world.player, world.multiworld)
    level_9 = Region("level_9", world.player, world.multiworld)
    level_10 = Region("level_10", world.player, world.multiworld)

    # Let's put all these regions in a list.
    regions = [level_1, level_2, level_3, level_4, level_5, level_6, level_7, level_8, level_9, level_10]

    # Some regions may only exist if the player enables certain options.
   

    # We now need to add these regions to multiworld.regions so that AP knows about their existence.
    world.multiworld.regions += regions


def connect_regions(world: ArchipelanoWorld) -> None:
    # We have regions now, but still need to connect them to each other.
    # But wait, we no longer have access to the region variables we created in create_all_regions()!
    # Luckily, once you've submitted your regions to multiworld.regions,
    # you can get them at any time using world.get_region(...).
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

    
    # An even easier way is to use the region.connect helper.
    level_1.connect(level_2, "Level 1 to Level 2", lambda state: state.has("Key_1", world.player))
    level_2.connect(level_3, "Level 2 to Level 3", lambda state: state.has("Key_2", world.player))
    level_3.connect(level_4, "Level 3 to Level 4", lambda state: state.has("Key_3", world.player))
    level_4.connect(level_5, "Level 4 to Level 5", lambda state: state.has("Key_4", world.player))
    level_5.connect(level_6, "Level 5 to Level 6", lambda state: state.has("Key_5", world.player))
    level_6.connect(level_7, "Level 6 to Level 7", lambda state: state.has("Key_6", world.player))
    level_7.connect(level_8, "Level 7 to Level 8", lambda state: state.has("Key_7", world.player))
    level_8.connect(level_9, "Level 8 to Level 9", lambda state: state.has("Key_8", world.player))
    level_9.connect(level_10, "Level 9 to Level 10", lambda state: state.has("Key_9", world.player))

    # Put all rules here, remove rules.py?

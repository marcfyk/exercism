// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {

    fn new(health: u32, mana: Option<u32>, level: u32) -> Player {
        Player { health, mana, level }
    }
    
    pub fn revive(&self) -> Option<Player> {
        let mana = if self.level < 10 { None } else { Some(100) };
        if self.health == 0 {
            Some(Player::new(100, mana, self.level))
        } else {
            None
        }
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        match self.mana {
            Some(m) => {
                if m < mana_cost {
                    0
                } else {
                    self.mana = Some(m - mana_cost);
                    mana_cost * 2
                }
            },
            None => {
                self.health -= std::cmp::min(self.health, mana_cost);
                0
            }
        }
    }
}

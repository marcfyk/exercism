pub struct Allergies(u32);

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum Allergen {
    Eggs = 1,
    Peanuts = 2,
    Shellfish = 4,
    Strawberries = 8,
    Tomatoes = 16,
    Chocolate = 32,
    Pollen = 64,
    Cats = 128,
}

const ALLERGENS: [Allergen; 8] = [
    Allergen::Eggs, Allergen::Peanuts, Allergen::Shellfish,
    Allergen::Strawberries, Allergen::Tomatoes, Allergen::Chocolate,
    Allergen::Pollen, Allergen::Cats,
];


impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies(score % 256)
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        let n = *allergen as u32;
        self.0 & n == n
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        ALLERGENS.iter()
            .filter(|a| self.is_allergic_to(&a))
            .cloned()
            .collect()
    }
}

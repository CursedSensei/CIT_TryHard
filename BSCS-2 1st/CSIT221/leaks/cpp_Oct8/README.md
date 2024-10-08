# **NOTE: Wrong akong removeNode... pero makasabot ramo kay wa ko naminaw sa comment HAHAHHAHAHAHA**

Naay uban test wa nako na tarong og export... pero ako na hinumduman ra kay katong "Insertion" sorted.

inig add kay mu insert sha sa node element in ascending order dayun mo return ka either 1 (ni start ka sa head) or 0 (ni start ka sa tail)


# LOGIC:
    if difference of elem to head is > elem to tail:
        start from tail
    else:
        start from head



# CODE:
    (i think with sentinels to, so yah)

    if (abs(elem - head->next->elem) > abs(elem - tail->next->elem)) {
        // from tail insertion
        return 0;
    } else {
        // from head insertion
        return 1;
    }

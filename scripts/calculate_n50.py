lengths = []
current_length = 0

with open("results/assembly/contigs.fasta") as f:
    for line in f:
        line = line.strip()

        if line.startswith(">"):
            if current_length > 0:
                lengths.append(current_length)
            current_length = 0
        else:
            current_length += len(line)

    if current_length > 0:
        lengths.append(current_length)

lengths.sort(reverse=True)

total_length = sum(lengths)
half_length = total_length / 2
cumulative = 0

for length in lengths:
    cumulative += length
    if cumulative >= half_length:
        n50 = length
        break

print("Total length:", total_length)
print("Number of contigs:", len(lengths))
print("N50:", n50)

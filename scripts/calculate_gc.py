total_bases = 0
gc_bases = 0

with open("results/assembly/contigs.fasta") as f:
    for line in f:
        if not line.startswith(">"):
            sequence = line.strip().upper()
            total_bases += len(sequence)
            gc_bases += sequence.count("G") + sequence.count("C")

gc_percent = (gc_bases / total_bases) * 100

print("Total bases:", total_bases)
print("GC bases:", gc_bases)
print("GC content:", round(gc_percent, 2), "%")

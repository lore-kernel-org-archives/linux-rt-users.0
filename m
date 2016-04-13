From: Clark Williams <williams@redhat.com>
Subject: [PATCH] cyclictest: avoid using libnuma cpumask parsing functions
Date: Wed, 13 Apr 2016 15:37:00 -0500
Message-ID: <20160413153700.7a930369@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/HCv+IRvGKgMRMgjc0tpG0Go"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/HCv+IRvGKgMRMgjc0tpG0Go
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

John,

I ran into issues with parsing cpu masks when trying to run this command:

sudo ./cyclictest -i100 -qmu -h 2000 -p95 -t1 -a3

I had previously booted a 4-core system with these boot options:

	isolcpus=3D3 nohz_full=3D3 rcu_nocbs=3D3

The intent was to run loads on cpus 0-2 while running cyclictest on the iso=
lated cpu 3.=20

Unfortunately, the libnuma function numa_parse_cpumask() (which we use when=
 it's available) seems to check the current affinity mask and fails the par=
se if any of the cpus in the input string are not in the current affinity m=
ask. I find this "unhelpful" when trying to place a measurement thread on a=
n isolated cpu.=20

This patch removes the wrapper function which uses libnuma cpumask parsing =
functions and instead uses the parser function we wrote for when libnuma is=
 not available.=20

Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/cyclictest/rt_numa.h | 82 ++++++++++++++++++++++----------------------=
----
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index ec2994314e80..d65cd421863b 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -32,6 +32,12 @@ static int numa =3D 0;
 #define LIBNUMA_API_VERSION 1
 #endif
=20
+#ifndef BITS_PER_LONG
+#define BITS_PER_LONG    (8*sizeof(long))
+#endif
+
+
+
 static void *
 threadalloc(size_t size, int node)
 {
@@ -89,22 +95,6 @@ static inline unsigned int rt_numa_bitmask_isbitset( con=
st struct bitmask *mask,
 	return numa_bitmask_isbitset(mask,i);
 }
=20
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
-{
-#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
-					   autotools build. */
-	return numa_parse_cpustring_all(s);
-#else
-	/* We really need numa_parse_cpustring_all(), so we can assign threads
-	 * to cores which are part of an isolcpus set, but early 2.x versions of
-	 * libnuma do not have this function.  A work around should be to run
-	 * your command with e.g. taskset -c 9-15 <command>
-	 */
-	return numa_parse_cpustring((char *)s);
-#endif
-}
-
 static inline void rt_bitmask_free(struct bitmask *mask)
 {
 	numa_bitmask_free(mask);
@@ -157,32 +147,6 @@ static inline unsigned int rt_numa_bitmask_isbitset( c=
onst struct bitmask *mask,
 	return (bit !=3D 0);
 }
=20
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
-{
-	int cpu;
-	struct bitmask *mask =3D NULL;
-	cpu =3D atoi(s);
-	if (0 <=3D cpu && cpu < max_cpus) {
-		mask =3D malloc(sizeof(*mask));
-		if (mask) {
-			/* Round up to integral number of longs to contain
-			 * max_cpus bits */
-			int nlongs =3D (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
-
-			mask->maskp =3D calloc(nlongs, sizeof(long));
-			if (mask->maskp) {
-				mask->maskp[cpu/BITS_PER_LONG] |=3D
-					(1UL << (cpu % BITS_PER_LONG));
-				mask->size =3D max_cpus;
-			} else {
-				free(mask);
-				mask =3D NULL;
-			}
-		}
-	}
-	return mask;
-}
=20
 static inline void rt_bitmask_free(struct bitmask *mask)
 {
@@ -204,8 +168,6 @@ struct bitmask {
     unsigned long size; /* number of bits in the map */
     unsigned long *maskp;
 };
-#define BITS_PER_LONG    (8*sizeof(long))
-
 static inline void *threadalloc(size_t size, int n) { return malloc(size);=
 }
 static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
 static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
@@ -280,4 +242,36 @@ static inline unsigned int rt_numa_bitmask_count(const=
 struct bitmask *mask)
 	return num_bits;
 }
=20
+/*
+ * Use this instead of a wrapper for libnuma functions.
+ * The libnuma function numa_parse_cpustring() checks the affinity mask
+ * and fails if an input cpu is not in the mask. This of course sucks when
+ * trying to place a thread on an isolated cpu. Avoid libnuma parsing func=
tions
+ */
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
+	int max_cpus)
+{
+	int cpu;
+	struct bitmask *mask =3D NULL;
+	cpu =3D atoi(s);
+	if (0 <=3D cpu && cpu < max_cpus) {
+		mask =3D malloc(sizeof(*mask));
+		if (mask) {
+			/* Round up to integral number of longs to contain
+			 * max_cpus bits */
+			int nlongs =3D (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
+
+			mask->maskp =3D calloc(nlongs, sizeof(long));
+			if (mask->maskp) {
+				mask->maskp[cpu/BITS_PER_LONG] |=3D
+					(1UL << (cpu % BITS_PER_LONG));
+				mask->size =3D max_cpus;
+			} else {
+				free(mask);
+				mask =3D NULL;
+			}
+		}
+	}
+	return mask;
+}
 #endif	/* _RT_NUMA_H */
--=20
2.5.5


--Sig_/HCv+IRvGKgMRMgjc0tpG0Go
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXDq3sAAoJEOI5asVwYXLrI7QP/1LY/6dE4wybV2EBVSdCxkYe
96YY9glHnXKX3ugzpbxeQFnWoEjwgDgndG8erdT7Xp0ygVwG02DATH+/KwHJq+Mb
OEti/MZLe4dZLs+46L/wkntGQX6KzLSf+JfIOW4eVVuDynNJ/7rQuEuXMgswsnU8
tarcL1kefdS7jL/1Mu6ADy+u0FICJkbYcSc8OU6yhgcCTehiVXGVztKi8fk9h675
RZW/xUAPITIVZ/wpaSN3n0U4A4oG4LTyAYu1mlqphqr5mUwvHHg0h+rxgK0w4Hu1
r3unju9VZozkY95wDZranXEiEalKtHIxtQ6x4qNnSPgPF5sIuqLe7h+9tEhF45lN
VG4EryaCAEJ6Yff936yOJrob/OeqqWHCQlGtWW0zAs/enaGC8vQ8qb8SKndcFvM5
pVuA3vIqmaNgFnUDy63zRR7jQDrvkzvqjmMHYP1kemZSZlM9g5Mm5SVpPEbp99Mh
H2xCAcQP4u5c+2JlYcyk+/rQVc+idREhQJEpREeztuJoI+fDjrA6pjZq2lOkcvhV
GQEzCo7lEDGAC9ZO8RMKkDyCd4DyVhsw49F6NMnwpzn9dUssLky5ZuuEsuBueVZ6
5L1vE847Nsuffr7dlKgN6AvvJt1wNB9ltM5i/v/28ShP/ems9d68XDImRft3QBOv
asH+koMjZsf1Niv+/yPE
=nHs1
-----END PGP SIGNATURE-----

--Sig_/HCv+IRvGKgMRMgjc0tpG0Go--

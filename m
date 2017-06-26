From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 26/32] tracing: Make duplicate count from tracing_map available
Date: Mon, 26 Jun 2017 17:49:27 -0500
Message-ID: <a04e0c203d1e6f097e6198eba74c661d77cd813b.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Though extremely rare, there can be duplicate entries in the tracing
map.  This isn't normally a problem, as the sorting code makes this
transparent by merging them during the sort.

It's useful to know however, as a check on that assumption - if a
non-zero duplicate count is seen more than rarely, it might indicate
an unexpected change to the algorithm, or a pathological data set.

Add an extra param to tracing_map_sort_entries() and use it to display
the value in the hist trigger output.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 14 ++++++++------
 kernel/trace/tracing_map.c       | 12 +++++++++---
 kernel/trace/tracing_map.h       |  3 ++-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 53a0634..ab94e2a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4011,7 +4011,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 }
 
 static int print_entries(struct seq_file *m,
-			 struct hist_trigger_data *hist_data)
+			 struct hist_trigger_data *hist_data,
+			 unsigned int *n_dups)
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
@@ -4019,7 +4020,7 @@ static int print_entries(struct seq_file *m,
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
-					     &sort_entries);
+					     &sort_entries, n_dups);
 	if (n_entries < 0)
 		return n_entries;
 
@@ -4038,6 +4039,7 @@ static void hist_trigger_show(struct seq_file *m,
 {
 	struct hist_trigger_data *hist_data;
 	int n_entries, ret = 0;
+	unsigned int n_dups;
 
 	if (n > 0)
 		seq_puts(m, "\n\n");
@@ -4047,15 +4049,15 @@ static void hist_trigger_show(struct seq_file *m,
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
-	n_entries = print_entries(m, hist_data);
+	n_entries = print_entries(m, hist_data, &n_dups);
 	if (n_entries < 0) {
 		ret = n_entries;
 		n_entries = 0;
 	}
 
-	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
-		   (u64)atomic64_read(&hist_data->map->hits),
-		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
+	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n    Duplicates: %u\n",
+		   (u64)atomic64_read(&hist_data->map->hits), n_entries,
+		   (u64)atomic64_read(&hist_data->map->drops), n_dups);
 }
 
 static int hist_show(struct seq_file *m, void *v)
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index f987069..9ed04b6 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1084,6 +1084,7 @@ static void sort_secondary(struct tracing_map *map,
  * @map: The tracing_map
  * @sort_key: The sort key to use for sorting
  * @sort_entries: outval: pointer to allocated and sorted array of entries
+ * @n_dups: outval: pointer to variable receiving a count of duplicates found
  *
  * tracing_map_sort_entries() sorts the current set of entries in the
  * map and returns the list of tracing_map_sort_entries containing
@@ -1100,13 +1101,16 @@ static void sort_secondary(struct tracing_map *map,
  * The client should not hold on to the returned array but should use
  * it and call tracing_map_destroy_sort_entries() when done.
  *
- * Return: the number of sort_entries in the struct tracing_map_sort_entry
- * array, negative on error
+ * Return: the number of sort_entries in the struct
+ * tracing_map_sort_entry array, negative on error.  If n_dups is
+ * non-NULL, it will receive the number of duplicate entries found
+ * (and merged) during the sort.
  */
 int tracing_map_sort_entries(struct tracing_map *map,
 			     struct tracing_map_sort_key *sort_keys,
 			     unsigned int n_sort_keys,
-			     struct tracing_map_sort_entry ***sort_entries)
+			     struct tracing_map_sort_entry ***sort_entries,
+			     unsigned int *n_dups)
 {
 	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
 			      const struct tracing_map_sort_entry **);
@@ -1147,6 +1151,8 @@ int tracing_map_sort_entries(struct tracing_map *map,
 	if (ret < 0)
 		goto free;
 	n_entries -= ret;
+	if (n_dups)
+		*n_dups = ret;
 
 	if (is_key(map, sort_keys[0].field_idx))
 		cmp_entries_fn = cmp_entries_key;
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 303bc4f..a44cc0c 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -286,7 +286,8 @@ extern void tracing_map_set_field_descr(struct tracing_map *map,
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
 			 unsigned int n_sort_keys,
-			 struct tracing_map_sort_entry ***sort_entries);
+			 struct tracing_map_sort_entry ***sort_entries,
+			 unsigned int *n_dups);
 
 extern void
 tracing_map_destroy_sort_entries(struct tracing_map_sort_entry **entries,
-- 
1.9.3

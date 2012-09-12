From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] hwlat_detector: Check the outer side of the loop
Date: Wed, 12 Sep 2012 10:34:11 -0400
Message-ID: <1347460451.10751.57.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Jon Masters <jcm@redhat.com>,
	Darren Hart <dvhart@linux.intel.com>,
	Clark Williams <clark@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The hwlat_detector performs the following test:

	t1 = ktime_get();
	t2 = ktime_get();

	[ do the checks of t2 - t1 ]

It can detect things like SMIs if it occurs between the t1 and t2
timestamps, as there will be a large difference between the two.

The problem is that it doesn't catch anything if there's a SMI between
the t2 of one iteration and the t1 of the next. As this part of the
count does the calculations, there's more time between t2 and the next
t1 than there is between t1 and t2. This means that if an SMI is
triggered, it is more likely to happen between t2 and the next t1 than
between t1 and t2 and will probably be missed. Especially if the SMI
only goes off once in a while (like one every two minutes).

Recording the time between t2 and the next t1 will cover this as well.
The output will now show three columns:

<timestamp>	<t2-t1 delta>	<t1-last_t2 delta>

where the third column shows the delta of the outer part of the loop,
and is reported if that is greater than the threshold.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
index b7b7c90..b53bdfa 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -143,6 +143,7 @@ static void detector_exit(void);
 struct sample {
 	u64		seqnum;		/* unique sequence */
 	u64		duration;	/* ktime delta */
+	u64		outer_duration;	/* ktime delta (outer loop) */
 	struct timespec	timestamp;	/* wall time */
 	unsigned long   lost;
 };
@@ -219,11 +220,13 @@ static struct sample *buffer_get_sample(struct sample *sample)
  */
 static int get_sample(void *unused)
 {
-	ktime_t start, t1, t2;
+	ktime_t start, t1, t2, last_t2;
 	s64 diff, total = 0;
 	u64 sample = 0;
+	u64 outer_sample = 0;
 	int ret = 1;
 
+	last_t2.tv64 = 0;
 	start = ktime_get(); /* start timestamp */
 
 	do {
@@ -231,6 +234,18 @@ static int get_sample(void *unused)
 		t1 = ktime_get();	/* we'll look for a discontinuity */
 		t2 = ktime_get();
 
+		if (last_t2.tv64) {
+			diff = ktime_to_us(ktime_sub(t1, last_t2));
+			/* This shouldn't happen */
+			if (diff < 0) {
+				printk(KERN_ERR BANNER "time running backwards\n");
+				goto out;
+			}
+			if (diff > outer_sample)
+				outer_sample = diff;
+		}
+		last_t2 = t2;
+
 		total = ktime_to_us(ktime_sub(t2, start)); /* sample width */
 		diff = ktime_to_us(ktime_sub(t2, t1));     /* current diff */
 
@@ -246,12 +261,13 @@ static int get_sample(void *unused)
 	} while (total <= data.sample_width);
 
 	/* If we exceed the threshold value, we have found a hardware latency */
-	if (sample > data.threshold) {
+	if (sample > data.threshold || outer_sample > data.threshold) {
 		struct sample s;
 
 		data.count++;
 		s.seqnum = data.count;
 		s.duration = sample;
+		s.outer_duration = outer_sample;
 		s.timestamp = CURRENT_TIME;
 		__buffer_add_sample(&s);
 
@@ -738,10 +754,11 @@ static ssize_t debug_sample_fread(struct file *filp, char __user *ubuf,
 		}
 	}
 
-	len = snprintf(buf, sizeof(buf), "%010lu.%010lu\t%llu\n",
-		      sample->timestamp.tv_sec,
-		      sample->timestamp.tv_nsec,
-		      sample->duration);
+	len = snprintf(buf, sizeof(buf), "%010lu.%010lu\t%llu\t%llu\n",
+		       sample->timestamp.tv_sec,
+		       sample->timestamp.tv_nsec,
+		       sample->duration,
+		       sample->outer_duration);
 
 
 	/* handling partial reads is more trouble than it's worth */

From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for
 histogram overflow instance tracking
Date: Wed, 14 Nov 2012 18:17:12 -0800 (PST)
Message-ID: <99151396.32193.1352945832244.JavaMail.root@vmware.com>
References: <50A42C51.6030004@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: frank rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:53990 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933149Ab2KOCRN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2012 21:17:13 -0500
In-Reply-To: <50A42C51.6030004@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a new command line option '-g' (long option '--of_max') to cap how many
outliers are tracked per thread.

$ sudo ./cyclictest -p 99 -m -n -a -h 5 -g 50 -t4 -D 30

policy: fifo: loadavg: 0.04 0.05 0.01 1/422 13994

T: 0 (13938) P:99 I:1000 C:  29996 Min:      2 Act:    3 Avg:    2 Max:      75
T: 1 (13939) P:99 I:1000 C:  29994 Min:      2 Act:    5 Avg:    3 Max:      12
T: 2 (13940) P:99 I:1000 C:  29991 Min:      2 Act:    4 Avg:    3 Max:       8
T: 3 (13941) P:99 I:1000 C:  29989 Min:      2 Act:    4 Avg:    3 Max:       8
  Histogram
000000 000000   000000  000000  000000
000001 000000   000000  000000  000000
000002 010425   000019  000012  000029
000003 017252   005100  008867  018353
000004 002277   021146  021048  011549
  Total: 000029954 000026265 000029927 000029931
  Min Latencies: 00002 00002 00002 00002
  Avg Latencies: 00002 00003 00003 00003
  Max Latencies: 00075 00012 00008 00008
  Histogram Overflows: 00046 03733 00069 00063
  Histogram Overflow at cycle number:
  Thread 0: 00475 00476 01311 01818 03183 03311 05569 08003 08741 08743 08745 08760 08761 09311 13922 14890 15476 15562 15563 17243 17250 17253 17254 17255 17256 17257 17258 17259 17270 17271 17272 18026 18752 19115 19700 20668 21031 21311 21813 22311 24782 26234 26960 28291 29259 29622
  Thread 1: 00000 00001 00002 00003 00004 00014 00024 00034 00035 00044 00045 00054 00055 00064 00065 00074 00075 00084 00085 00095 00105 00115 00125 00135 00145 00146 00149 00155 00156 00165 00166 00175 00176 00185 00186 00188 00195 00196 00206 00216 00226 00233 00236 00246 00256 00257 00266 00267 00276 00277 # 03683 others
  Thread 2: 00000 00001 00002 00228 00471 01301 02471 02472 02912 03301 03472 05301 05307 05314 05565 06472 07301 07472 08472 08711 08737 08738 08740 08757 09301 10228 11301 13301 14472 15301 15472 15566 17241 17247 17249 17250 17251 17252 17253 17254 17255 17256 17257 17262 17266 17267 17268 17301 17472 18472 # 00019 others
  Thread 3: 00000 00469 01296 02469 02470 03296 05296 05562 06554 06555 07296 07308 08736 08737 08738 08739 08740 08741 08742 08743 08744 08745 08746 08747 08748 08749 08750 08751 08752 08753 08754 09296 09308 11296 13296 14470 15296 15308 15470 15564 16554 16555 17245 17246 17248 17249 17253 17254 17265 17296 # 00013 others

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>

---
> > Here's my attempt at addressing Frank's suggestions. Please correct
> > me if I've misunderstood what you were suggesting.
> 
> It addresses the issues related to the size of stat->outliers.  But
> does
> not address my other suggestions.
> 
> If you want to ignore my other suggestions, that is ok.

I would like to address all your suggestions. Which ones did I miss?

> More comments inline below.
> 
> 
> Patch is not against the current git repository, so fails:
> 
> patching file src/cyclictest/cyclictest.c
> Hunk #2 succeeded at 888 (offset 33 lines).
> Hunk #3 succeeded at 965 with fuzz 2 (offset 34 lines).
> Hunk #4 FAILED at 1061.
> Hunk #5 FAILED at 1092.
> Hunk #6 succeeded at 1168 with fuzz 1 (offset 50 lines).
> Hunk #7 succeeded at 1707 (offset 141 lines).
> Hunk #8 succeeded at 1837 (offset 141 lines).

Yikes! After all these years, I'm still a n00b when it comes to git things. Really sorry about that! It took me a couple of hours just to get my git tree back in shape, after messing it up in strange ways.

> >  			{"ftrace", no_argument, NULL, 'f'},
> > +			{"ftrace", no_argument, NULL, 'f'},
> 
> ftrace already exists in previous line.
> 

Fixed. Sorry.

> > +		int c = getopt_long(argc, argv,
> > "a::b:Bc:Cd:Efg:h:H:i:Il:MnNo:O:p:PmqQrsS"
> > +				    "t::uUvD:wWT:y:e:", long_options, &option_index);
> 
> nit: I don't see the point of splitting the constant string.  The
> line is over long both before
> and after the change.  If adding one character makes the string too
> long, I would suggest
> moving it to a new line, indented to match "long_options,
> &option_index);".

Like you said, the string was too long to being with, so I left it as is, with my addition.

> Should ensure that of_max is not negative.

Done.

---
 src/cyclictest/cyclictest.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index abf3e8b..bfd1324 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -91,6 +91,7 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 #define NSEC_PER_SEC           1000000000

 #define HIST_MAX               1000000
+#define OF_MAX                  1000000

 #define MODE_CYCLIC            0
 #define MODE_CLOCK_NANOSLEEP   1
@@ -171,6 +172,7 @@ static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int histofall = 0;
+static int of_max = 0;
 static int duration = 0;
 static int use_nsecs = 0;
 static int refresh_on_max;
@@ -887,7 +889,7 @@ void *timerthread(void *param)
                if (histogram) {
                        if (diff >= histogram) {
                                stat->hist_overflow++;
-                                if (stat->num_outliers < histogram)
+                                if (stat->num_outliers < of_max)
                                        stat->outliers[stat->num_outliers++] = stat->cycles;
                        }
                        else
@@ -964,6 +966,7 @@ static void display_help(int error)
               "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
               "-E       --event           event tracing (used with -b)\n"
               "-f       --ftrace          function trace (when -b is active)\n"
+              "-g MAX   --of_max=MAX      Report cycle instances (up to MAX) for histogram overflows\n"
               "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
               "                           (with same priority about many threads)\n"
               "                           US is the max time to be be tracked in microseconds\n"
@@ -1102,6 +1105,7 @@ static void process_options (int argc, char *argv[])
                        {"latency",          required_argument, NULL, 'e'},
                        {"event",            no_argument,       NULL, 'E'},
                        {"ftrace",           no_argument,       NULL, 'f'},
+                       {"of_max",           required_argument, NULL, 'g'},
                        {"histogram",        required_argument, NULL, 'h'},
                        {"histofall",        required_argument, NULL, 'H'},
                        {"interval",         required_argument, NULL, 'i'},
@@ -1133,7 +1137,7 @@ static void process_options (int argc, char *argv[])
                        {"help",             no_argument,       NULL, '?'},
                        {NULL, 0, NULL, 0}
                };
-               int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
+               int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efg:h:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
                                    long_options, &option_index);
                if (c == -1)
                        break;
@@ -1166,6 +1170,7 @@ static void process_options (int argc, char *argv[])
                        break;
                case 'E': enable_events = 1; break;
                case 'f': tracetype = FUNCTION; ftrace = 1; break;
+               case 'g': of_max = atoi(optarg); break;
                case 'H': histofall = 1; /* fall through */
                case 'h': histogram = atoi(optarg); break;
                case 'i': interval = atoi(optarg); break;
@@ -1290,6 +1295,12 @@ static void process_options (int argc, char *argv[])
        if (histogram > HIST_MAX)
                histogram = HIST_MAX;

+       if (of_max < 0)
+               error = 1;
+
+       if (of_max > OF_MAX)
+               of_max = OF_MAX;
+
        if (histogram && distance != -1)
                warn("distance is ignored and set to 0, if histogram enabled\n");
        if (distance == -1)
@@ -1706,11 +1717,17 @@ int main(int argc, char **argv)
                        int bufsize = histogram * sizeof(long);

                        stat->hist_array = threadalloc(bufsize, node);
-                       stat->outliers = threadalloc(bufsize, node);
-                       if (stat->hist_array == NULL || stat->outliers == NULL)
+                       if (stat->hist_array == NULL)
                                fatal("failed to allocate histogram of size %d on node %d\n",
                                      histogram, i);
                        memset(stat->hist_array, 0, bufsize);
+               }
+               if (of_max) {
+                       int bufsize = of_max * sizeof(long);
+                       stat->outliers = threadalloc(bufsize, node);
+                       if (stat->outliers == NULL)
+                               fatal("failed to allocate outliers of size %d on node %d\n",
+                                     histogram, i);
                        memset(stat->outliers, 0, bufsize);
                }

@@ -1829,7 +1846,7 @@ int main(int argc, char **argv)
                print_hist(parameters, num_threads);
                for (i = 0; i < num_threads; i++) {
                        threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-                       threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+                       threadfree(statistics[i]->outliers, of_max*sizeof(long), parameters[i]->node);
                }
        }

--
1.7.1

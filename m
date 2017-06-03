From: rolf.freitag@email.de
Subject: [PATCH] no compile warnings from cyclictest
Date: Sat, 3 Jun 2017 12:01:24 +0200
Message-ID: <trinity-e47892ae-17fb-4f87-8381-f313303cfe09-1496484084736@3capp-webde-bs10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:61175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbdFCKB1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 3 Jun 2017 06:01:27 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

compiling cyclictest gives 4 warnings of type

  warning: ignoring return value of 'write'

and three of type

  warning: ... may be used uninitialized in this function

So i eleminated the first sort with a trash variable, which adds up 
the return values and recycles them (their entropy) at the end via
srand(). This also avoids a write-only variable.
I eleminated the second sort by initializing the variables.

--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -222,6 +222,7 @@ static int use_fifo = 0;
 static pthread_t fifo_threadid;
 static int laptop = 0;
 static int use_histfile = 0;
+static unsigned int trash; // for unused return values, to avoid compiler warnings because of ignored return values
 
 #ifdef ARCH_HAS_SMI_COUNTER
 static int smi = 0;
@@ -491,10 +492,10 @@ static void tracemark(char *fmt, ...)
        va_end(ap);
 
        /* write the tracemark message */
-       write(tracemark_fd, tracebuf, len);
+       trash += write(tracemark_fd, tracebuf, len);
 
        /* now stop any trace */
-       write(trace_fd, "0\n", 2);
+       trash += write(trace_fd, "0\n", 2);
 }
 
 
@@ -510,7 +511,7 @@ static void tracing(int on)
                case KV_26_LT24: prctl(0, 1); break;
                case KV_26_33:
                case KV_30:
-                       write(trace_fd, "1", 1);
+                       trash += write(trace_fd, "1", 1);
                        break;
                default:         break;
                }
@@ -520,7 +521,7 @@ static void tracing(int on)
                case KV_26_LT24: prctl(0, 0); break;
                case KV_26_33:
                case KV_30:
-                       write(trace_fd, "0", 1);
+                       trash += write(trace_fd, "0", 1);
                        break;
                default:        break;
                }
@@ -984,8 +985,10 @@ static void *timerthread(void *param)
        int stopped = 0;
        cpu_set_t mask;
        pthread_t thread;
-       unsigned long smi_now, smi_old;
+       unsigned long smi_now, smi_old=0;
 
+    memset(&stop, 0, sizeof(stop)); /* grrr */
+    
        /* if we're running in numa mode, set our memory node */
        if (par->node != -1)
                rt_numa_set_numa_run_on_node(par->node, par->cpu);
@@ -1066,7 +1069,6 @@ static void *timerthread(void *param)
        tsnorm(&next);
 
        if (duration) {
-               memset(&stop, 0, sizeof(stop)); /* grrr */
                stop = now;
                stop.tv_sec += duration;
        }
@@ -2623,5 +2625,7 @@ int main(int argc, char **argv)
        if (affinity_mask)
                rt_bitmask_free(affinity_mask);
 
+    srand(trash); // recycling of the trash (unused return values)
+    
        exit(ret);
 }

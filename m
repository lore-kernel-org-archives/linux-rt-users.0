From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Mon, 22 Oct 2012 18:16:06 -0700
Message-ID: <5085EFD6.7080500@am.sony.com>
References: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:34762 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932409Ab2JWBQI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2012 21:16:08 -0400
In-Reply-To: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/16/12 10:02, Bhavesh Davda wrote:
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Add feature to cyclictest histogram mode to track cycle counts every time a
> sample overflows the histogram limit. This should help identify if there is a
> timing pattern to jitters in cyclictest runs.
> 
> Example output (with -h 10):
>  ...
>  Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000 00001
>  Histogram Overflow at cycle number:
>  Thread 0: 09964
>  Thread 1: 00000 00004 00006 00008 00010 09962 11594
>  Thread 2:
>  Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
>  Thread 4: 11574 11580 11583 11586
>  Thread 5: 00020 09448 13954 14954 18954 20587 24973
>  Thread 6:
>  Thread 7: 18950
>  ...
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>


After the patches survive checkpatch, I'll review and test them.

As far as the line length warnings are concerned, cyclictest has
a _lot_ of lines longer than 80 characters, so just use your
best judgement as to whether there is a good way to change the
patch to fit within 80 characters, or if the change is consistent
with cyclictest style.


>From checkpatch:


If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
ERROR: code indent should use tabs where possible
#38: FILE: src/cyclictest/cyclictest.c:153:
+        long *outliers;$

WARNING: please, no spaces at the start of a line
#38: FILE: src/cyclictest/cyclictest.c:153:
+        long *outliers;$

ERROR: code indent should use tabs where possible
#46: FILE: src/cyclictest/cyclictest.c:161:
+        long num_outliers;$

WARNING: please, no spaces at the start of a line
#46: FILE: src/cyclictest/cyclictest.c:161:
+        long num_outliers;$

ERROR: code indent should use tabs where possible
#57: FILE: src/cyclictest/cyclictest.c:857:
+                                if (stat->num_outliers < histogram)$

WARNING: please, no spaces at the start of a line
#57: FILE: src/cyclictest/cyclictest.c:857:
+                                if (stat->num_outliers < histogram)$

WARNING: line over 80 characters
#58: FILE: src/cyclictest/cyclictest.c:858:
+					stat->outliers[stat->num_outliers++] = stat->cycles;

WARNING: line over 80 characters
#74: FILE: src/cyclictest/cyclictest.c:1416:
+			printf(" # %05lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);

WARNING: line over 80 characters
#102: FILE: src/cyclictest/cyclictest.c:1691:
+			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);

total: 3 errors, 6 warnings, 67 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

/home/frowand/tmp/hist_overflow_xxx_1 has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
ERROR: Does not appear to be a unified-diff format patch

total: 1 errors, 0 warnings, 0 lines checked




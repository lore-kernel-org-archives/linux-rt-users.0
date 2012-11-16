From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Thu, 15 Nov 2012 16:11:42 -0800
Message-ID: <50A584BE.2000107@am.sony.com>
References: <99151396.32193.1352945832244.JavaMail.root@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [213.199.154.140] ([213.199.154.140]:52266 "EHLO
	db3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab2KPANT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2012 19:13:19 -0500
In-Reply-To: <99151396.32193.1352945832244.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/14/12 18:17, Bhavesh Davda wrote:
> Add a new command line option '-g' (long option '--of_max') to cap how many
> outliers are tracked per thread.
> 
> $ sudo ./cyclictest -p 99 -m -n -a -h 5 -g 50 -t4 -D 30
> 
> policy: fifo: loadavg: 0.04 0.05 0.01 1/422 13994
> 
> T: 0 (13938) P:99 I:1000 C:  29996 Min:      2 Act:    3 Avg:    2 Max:      75
> T: 1 (13939) P:99 I:1000 C:  29994 Min:      2 Act:    5 Avg:    3 Max:      12
> T: 2 (13940) P:99 I:1000 C:  29991 Min:      2 Act:    4 Avg:    3 Max:       8
> T: 3 (13941) P:99 I:1000 C:  29989 Min:      2 Act:    4 Avg:    3 Max:       8
>   Histogram
> 000000 000000   000000  000000  000000
> 000001 000000   000000  000000  000000
> 000002 010425   000019  000012  000029
> 000003 017252   005100  008867  018353
> 000004 002277   021146  021048  011549
>   Total: 000029954 000026265 000029927 000029931
>   Min Latencies: 00002 00002 00002 00002
>   Avg Latencies: 00002 00003 00003 00003
>   Max Latencies: 00075 00012 00008 00008
>   Histogram Overflows: 00046 03733 00069 00063
>   Histogram Overflow at cycle number:
>   Thread 0: 00475 00476 01311 01818 03183 03311 05569 08003 08741 08743 08745 08760 08761 09311 13922 14890 15476 15562 15563 17243 17250 17253 17254 17255 17256 17257 17258 17259 17270 17271 17272 18026 18752 19115 19700 20668 21031 21311 21813 22311 24782 26234 26960 28291 29259 29622
>   Thread 1: 00000 00001 00002 00003 00004 00014 00024 00034 00035 00044 00045 00054 00055 00064 00065 00074 00075 00084 00085 00095 00105 00115 00125 00135 00145 00146 00149 00155 00156 00165 00166 00175 00176 00185 00186 00188 00195 00196 00206 00216 00226 00233 00236 00246 00256 00257 00266 00267 00276 00277 # 03683 others
>   Thread 2: 00000 00001 00002 00228 00471 01301 02471 02472 02912 03301 03472 05301 05307 05314 05565 06472 07301 07472 08472 08711 08737 08738 08740 08757 09301 10228 11301 13301 14472 15301 15472 15566 17241 17247 17249 17250 17251 17252 17253 17254 17255 17256 17257 17262 17266 17267 17268 17301 17472 18472 # 00019 others
>   Thread 3: 00000 00469 01296 02469 02470 03296 05296 05562 06554 06555 07296 07308 08736 08737 08738 08739 08740 08741 08742 08743 08744 08745 08746 08747 08748 08749 08750 08751 08752 08753 08754 09296 09308 11296 13296 14470 15296 15308 15470 15564 16554 16555 17245 17246 17248 17249 17253 17254 17265 17296 # 00013 others
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> 
> ---
>>> Here's my attempt at addressing Frank's suggestions. Please correct
>>> me if I've misunderstood what you were suggesting.
>>
>> It addresses the issues related to the size of stat->outliers.  But
>> does
>> not address my other suggestions.
>>
>> If you want to ignore my other suggestions, that is ok.
> 
> I would like to address all your suggestions. Which ones did I miss?

| Add a line to the histogram overflow cycle report that merges all
| threads into a single time line.  This is controlled by the -H
| option which already serves a similar purpose for histograms.

The merged data line is an enhancement.  If there is no strong request
from anyone for the feature then no need to include.  But it seems
useful to me.


| Removed leading zeros from cycle values reported in the histogram
| overflow cycle report to make the values more readable.

I should have also mentioned that many programs interpret numbers
with leading zeros as octal.

(Note that the existing histogram code uses the same printf()
format creating data with leading zeros.  I should submit a
separate patch, independent of the overflow instance tracking,
to fix that.)


| Removed extra blank line printed at end of Histogram output.

Some graphing programs are sensitive to extraneous blank lines,
so I try to avoid adding additional blank lines.


| One further thought...  The histogram overflow cycle report shows
| what cycle the overflow occurred in, not the actual time.  Adding
| the merged for all threads cycle times works because the histogram
| turns off the "different intervals for different threads" option:
| 
|                 if (!histogram) /* same interval on CPUs */
|                         interval += distance;
| 
| but if that ever changes then cycle is not a useful value to be
| reporting.
| 
| So it seems like it would be useful to convert cycle to a time
| in the report.  This is something that would have to be done
| anyway in post processing when trying to make use of the report.

This was probably the most important comment.


>> More comments inline below.

< snip >

This version of the patch addressed all of my inline comments.

But this version of the patch seems to have tabs converted to spaces, so
it doesn't apply.  My email servers sometimes alter white space in patches
so I double checked the patch on a list server at:

   http://marc.info/?l=linux-rt-users&m=135294583618844&q=raw

If the problem really is just at my end then don't worry about it
(what matters most is that John gets a clean version).

When force applied, the patch compiles and generates output
as expected.

-Frank


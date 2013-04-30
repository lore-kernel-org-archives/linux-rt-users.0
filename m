From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: Need help to measure and tune the latency in Linux RT
Date: Tue, 30 Apr 2013 07:10:21 -0400
Message-ID: <20130430111021.GC31290@titan.lakedaemon.net>
References: <CALJd4cbfqRFiGHshv8A+0A8kFo_qW=rvREsdgj3jQ=-0Rix0-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-embedded@vger.kernel.org, linux-newbie@vger.kernel.org,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rt-users@vger.kernel.org
To: Ashoka K <ashok.vinu@gmail.com>
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALJd4cbfqRFiGHshv8A+0A8kFo_qW=rvREsdgj3jQ=-0Rix0-g@mail.gmail.com>
Sender: linux-newbie-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ashoka,

linux-embedded is pretty quiet.  I'm not even sure why I'm still
subscribed to it.  You'll have better luck with your question by asking
on linux-arm-kernel (added to the cc).  I believe there is also a
linux-rt-users mailinglist [1].  A few comments below:

On Tue, Apr 30, 2013 at 01:57:21PM +0530, Ashoka K wrote:
> Hi,
> 
> I have an embedded system running 2.6.33 cross compiled for ARM OMAP
> with 1 GHZ uni-processor system.

Wow, this is ancient.  Is this a vanilla kernel?  If it's a vendor
kernel, you'll need to ask the vendor.

> The application has many threads and processes (around 15 total). In
> that 1 thread is time critical and must run every interval confiurable
> as 2, 4 or 8 milli sec etc. There is another thread which transfers
> Images to a FTP or to HMI etc, whoever requested the image.
> With this image transfer enabled my critical process misses the
> deadline and timesout. This critical thread is at RR priority 50. I
> used a HR timer thread with RR pri 55 to wakeup the critical thread
> every 1 milli sec to do the job.
> If image transfer is enabled i see that real time thread misses deadlines.
> 
> All traffic is flowing on common ethernet connection. Does it affect
> in any way ?
> 
> How to find out where the kernel is waiting or delaying to schedule
> the critical thread even though it is at higher RR priority. How to
> measure the latency ?
> 
> I am trying to use Oprofile tool, but got some error in cross
> compiling. Doesn't these tools add their own latency to the original
> problem ?
> 
> Any tools ? which one is better. Please provide your input on this.

I'm not the guy to answer this ;-)  I'll just forward to the appropriate
lists.

hth,

Jason.

[1] http://vger.kernel.org/vger-lists.html#linux-rt-users
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs

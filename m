From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Fri, 16 Nov 2012 18:41:39 -0800
Message-ID: <50A6F963.9000207@am.sony.com>
References: <1376702282.1876429.1353030991353.JavaMail.root@vmware.com> <50A5A3D7.7090904@am.sony.com> <50A6F713.7010806@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Bhavesh Davda <bhavesh@vmware.com>, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:1952 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984Ab2KQClp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Nov 2012 21:41:45 -0500
In-Reply-To: <50A6F713.7010806@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/16/12 18:31, Frank Rowand wrote:

< snip >
 
> I graphed the results with the msec data and with the nanosecond
> timestamps for an artificial test (two test runs for each case):
> 
>   nanosecond:  junk7.gif    junk10.gif
>   msec:        junk8_d.gif  junk9_d.gif
> 
> The cyclictest latency disruptions seem more visible to me in the
> nanosecond data graphs.  But that is just a first impression
> without playing around with a lot of different data sets.

John, Bhavesh,

OK, so after all of that, I'm going on vacation for a week.
I hope the rest of you are taking some time off too.

My conclusion after my data creation and graphing exercise is that
it might be good if people could play around with collecting and
analyzing real histogram overflow data and see what data formats
provide useful information.

I think we should not rush the patch into John's tree so that we
aren't stuck with a format or type of data that is not optimal.

Bhavesh, if you created this feature based on a real world need
(instead of just a brilliant mind exercise), it would be great
if you could apply the latest iteration (or iterations in the
near future) to your actual data collection and provide a real
world example of how this feature makes cyclictest better.

Thanks,

Frank


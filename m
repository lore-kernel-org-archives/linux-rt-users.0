From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for
 histogram overflow instance tracking
Date: Mon, 26 Nov 2012 13:37:54 -0800 (PST)
Message-ID: <1463873663.4023529.1353965874630.JavaMail.root@vmware.com>
References: <50B3DBAC.90208@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: frank rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:51055 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754138Ab2KZVh5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Nov 2012 16:37:57 -0500
In-Reply-To: <50B3DBAC.90208@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On 11/16/12 18:41, Frank Rowand wrote:
> > On 11/16/12 18:31, Frank Rowand wrote:
> > 
> > < snip >
> >  
> >> I graphed the results with the msec data and with the nanosecond
> >> timestamps for an artificial test (two test runs for each case):
> >>
> >>   nanosecond:  junk7.gif    junk10.gif
> >>   msec:        junk8_d.gif  junk9_d.gif
> >>
> >> The cyclictest latency disruptions seem more visible to me in the
> >> nanosecond data graphs.  But that is just a first impression
> >> without playing around with a lot of different data sets.
> > 
> > John, Bhavesh,
> > 
> > OK, so after all of that, I'm going on vacation for a week.
> > I hope the rest of you are taking some time off too.
> 
> I'm back...  Bhavesh, have you had a chance to think about my last
> several emails (my comments on your latest patch, my proposed patch,
> and the email I'm responding to)?  Any comments?

Hello Frank. Welcome back. I was out for the long weekend and am just getting back in the swing of things too, so sorry about the delay.

I do have real use cases for this "outlier" mode, that I've used effectively to identify sources of high latencies of cyclictest running in a Linux-rt kernel based VM on our VMware ESXi hypervisor. The patterns in the outliers, for various thresholds (e.g. 50 us) have helped me identify timers and callbacks in the hypervisor kernel (vmkernel) which have caused time to be "stolen" away from scheduling the virtual CPUs of the VM to do various housekeeping tasks, and to either move those timers out to other physical CPUs or to limit the time spend in those timers and callbacks to have a smaller impact on the cyclictest latencies.

I'm hoping that others in the community find similar uses of this "outlier" feature of cyclictest.

That said, I realize that not every use cases might fit my exact mould and might require either different formatting, or different granularities of the "outliers" output. So I'm open to suggestions in that regard.

I'm going to respond to your proposed patch next.

Thanks

- Bhavesh

> 
> > 
> > My conclusion after my data creation and graphing exercise is that
> > it might be good if people could play around with collecting and
> > analyzing real histogram overflow data and see what data formats
> > provide useful information.
> > 
> > I think we should not rush the patch into John's tree so that we
> > aren't stuck with a format or type of data that is not optimal.
> > 
> > Bhavesh, if you created this feature based on a real world need
> > (instead of just a brilliant mind exercise), it would be great
> > if you could apply the latest iteration (or iterations in the
> > near future) to your actual data collection and provide a real
> > world example of how this feature makes cyclictest better.
> > 
> > Thanks,
> > 
> > Frank
> 
> 
> 

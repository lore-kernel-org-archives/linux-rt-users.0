From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: 2.6.28-rt on PowerPC
Date: Thu, 29 Jan 2009 20:51:09 -0500
Message-ID: <1233280269.3833.60.camel@localhost.localdomain>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	 <1233270043.3833.57.camel@localhost.localdomain>
	 <49823A13.50703@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: avorontsov@ru.mvista.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:35304 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbZA3Bv0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 20:51:26 -0500
In-Reply-To: <49823A13.50703@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2009-01-29 at 15:21 -0800, Frank Rowand wrote:
> Steven Rostedt wrote:

> Your email can at an opportune time for me...  I was starting to try
> 2.6.28-rt on ARM and quickly came to the conclusion that the arch
> patches weren't the focus yet.  But I'm currently side-tracked with
> getting my board to even boot a vanilla 2.6.28 kernel first.  Do
> you expect to get to the arches in the next week or two?  If not,
> I may head down that path for ARM myself.

I'm going to try to apply the arch patches, but I do not have an arm
board myself. I do have a PPC64 box that works, but that's about it. I
have a powerbook too, but that box has never been able to boot an -rt
kernel. Who knows, maybe this one will boot.

I will create an rt/arm and an rt/ppc branch for the specific changes on
each. I'll try to get them next week (maybe tomorrow if things go better
than planned).

-- Steve



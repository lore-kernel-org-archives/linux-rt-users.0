From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 2 Nov 2016 13:41:29 -0400
Message-ID: <20161102134129.46b98de7@redhat.com>
References: <20161012111251.74d1d52e@redhat.com>
        <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
        <20161102165149.kg66lwfon6phhfik@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org,
        mst@redhat.com, paulmck@linux.vnet.ibm.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756288AbcKBRlb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2016 13:41:31 -0400
In-Reply-To: <20161102165149.kg66lwfon6phhfik@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2 Nov 2016 17:51:49 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2016-10-12 11:21:14 [-0500], Julia Cartwright wrote:
> > Something like this, perhaps?
> > 
> >    Julia
> > 
> > -- 8< --
> > Subject: [PATCH] rcu: enable rcu_normal_after_boot by default for RT  
> 
> finally applied and dropped ("net: Make synchronize_rcu_expedited()
> conditional on !RT_FULL").

Cool, thanks for all involved!

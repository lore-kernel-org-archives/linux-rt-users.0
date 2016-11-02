From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 2 Nov 2016 17:51:49 +0100
Message-ID: <20161102165149.kg66lwfon6phhfik@linutronix.de>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org, mst@redhat.com,
        paulmck@linux.vnet.ibm.com
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbcKBQvy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2016 12:51:54 -0400
Content-Disposition: inline
In-Reply-To: <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-12 11:21:14 [-0500], Julia Cartwright wrote:
> Something like this, perhaps?
> 
>    Julia
> 
> -- 8< --
> Subject: [PATCH] rcu: enable rcu_normal_after_boot by default for RT

finally applied and dropped ("net: Make synchronize_rcu_expedited()
conditional on !RT_FULL").

Sebastian

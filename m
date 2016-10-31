From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Making rcu_normal=1 in RT
Date: Mon, 31 Oct 2016 18:38:52 +0100
Message-ID: <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
References: <20161012111251.74d1d52e@redhat.com>
 <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
 <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
 <20161012203223.GK29518@linux.vnet.ibm.com>
 <20161013191332-mutt-send-email-mst@kernel.org>
 <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945074AbcJaRi7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2016 13:38:59 -0400
Content-Disposition: inline
In-Reply-To: <20161016112846.GR29518@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-16 04:28:46 [-0700], Paul E. McKenney wrote:
> If the relevant maintainers are OK with that, I am OK with it as long
> as it is non-default (at least to begin with) and does not introduce
> additional Kconfig questions.  My guess is that a boot parameter would
> work best, but something to discuss.

Okay. For me to summary:
- we want rcu_normal_after_boot=1 on -RT via CONFIG_PREEMPT_RT_FULL

- this makes synchronize_rcu_expedited() behave like
  synchronize_rcu() and therefore I can drop all patches replacing
  synchronize_rcu_expedited() with synchronize_rcu().

- optionally it has been requested to make synchronize_rcu() behave like
  synchronize_rcu_expedited() on shutdown and kexec().

Did I miss understood / forgot something?
> 							Thanx, Paul

Sebastian

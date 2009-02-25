From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.29-rc bug near nf_conntrack_tuple_taken
Date: Thu, 26 Feb 2009 00:35:20 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0902260034330.9135@localhost.localdomain>
References: <alpine.LSU.2.00.0902240044320.8597@fbirervta.pbzchgretzou.qr> <49A400D7.1010404@trash.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Engelhardt <jengelh@medozas.de>,
	linux-rt-users@vger.kernel.org,
	Netfilter Developer Mailing List
	<netfilter-devel@vger.kernel.org>
To: Patrick McHardy <kaber@trash.net>
Return-path: <netfilter-devel-owner@vger.kernel.org>
In-Reply-To: <49A400D7.1010404@trash.net>
Sender: netfilter-devel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 24 Feb 2009, Patrick McHardy wrote:
> This would mean something has used the non-rcu list functions
> when removing a conntrack from the hash. Which I don't see
> happening anywhere. Another possibility would be that the connntrack
> was already confirmed when the tuple got mangled and the list
> got corrupted. The pr_debug in nf_conntrack_alter_reply should
> trigger in that case.

Don't worry, that's a fallout of -rt, which is fixed in 2.6.29-rc6-rt3
already.

Thanks,

	tglx

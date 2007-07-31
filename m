From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: [PATCH] expand /proc/interrupts to include missing vectors, v2
Date: Tue, 31 Jul 2007 02:48:07 +0200
Message-ID: <46AE86C7.3060702@googlemail.com>
References: <20070726180522.GA1486@tsunami.ccur.com> <46A8EE78.4040702@zytor.com> <1185816797.3170.1.camel@sven.thebigcorporation.com> <20070730123206.abeab890.akpm@linux-foundation.org> <20070731001718.GA14295@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	"H. Peter Anvin" <hpa@zytor.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jason.baietto@ccur.com
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:19095 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbXGaAws (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 20:52:48 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2512124mue
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jul 2007 17:52:47 -0700 (PDT)
In-Reply-To: <20070731001718.GA14295@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Joe Korty wrote:
> +#ifdef CONFIG_SMP
> +		seq_printf(p, "RES: ");
> +		for_each_online_cpu(j)
> +			seq_printf(p, "%10u ",
> +				per_cpu(irq_stat,j).irq_resched_counts);
> +		seq_printf(p, "  Rescheduling interrupts\n");
> +#endif
> +#ifdef CONFIG_SMP
> +		seq_printf(p, "CAL: ");
> +		for_each_online_cpu(j)
> +			seq_printf(p, "%10u ",
> +				per_cpu(irq_stat,j).irq_call_counts);
> +		seq_printf(p, "  function call interrupts\n");
> +#endif
> +#ifdef CONFIG_SMP
> +		seq_printf(p, "TLB: ");
> +		for_each_online_cpu(j)
> +			seq_printf(p, "%10u ",
> +				per_cpu(irq_stat,j).irq_tlb_counts);
> +		seq_printf(p, "  TLB shootdowns\n");
> +#endif


How about :

#ifdef CONFIG_SMP
		seq_printf(p, "RES: ");
		for_each_online_cpu(j)
			seq_printf(p, "%10u ",
				per_cpu(irq_stat,j).irq_resched_counts);
		seq_printf(p, "  Rescheduling interrupts\n");

		seq_printf(p, "CAL: ");
		for_each_online_cpu(j)
			seq_printf(p, "%10u ",
				per_cpu(irq_stat,j).irq_call_counts);
		seq_printf(p, "  function call interrupts\n");

		seq_printf(p, "TLB: ");
		for_each_online_cpu(j)
			seq_printf(p, "%10u ",
				per_cpu(irq_stat,j).irq_tlb_counts);
		seq_printf(p, "  TLB shootdowns\n");
#endif


should to the same.


Regards,

Gabriel C

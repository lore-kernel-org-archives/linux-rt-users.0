From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] expand /proc/interrupts to include missing vectors, v2
Date: Mon, 30 Jul 2007 18:48:36 -0700
Message-ID: <20070730184836.63ad64d2.akpm@linux-foundation.org>
References: <20070726180522.GA1486@tsunami.ccur.com>
	<46A8EE78.4040702@zytor.com>
	<1185816797.3170.1.camel@sven.thebigcorporation.com>
	<20070730123206.abeab890.akpm@linux-foundation.org>
	<20070731001718.GA14295@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <sdietrich@novell.com>,
	"H. Peter Anvin" <hpa@zytor.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jason.baietto@ccur.com
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S940364AbXGaBuE@vger.kernel.org>
In-Reply-To: <20070731001718.GA14295@tsunami.ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 30 Jul 2007 20:17:18 -0400 Joe Korty <joe.korty@ccur.com> wrote:

> +		seq_printf(p, "RES: ");
> +		seq_printf(p, "CAL: ");
> +		seq_printf(p, "TLB: ");
> +		seq_printf(p, "TRM: ");

Documentation/filesystems/proc.txt presently describes NMI:, LOC: and ERR:.
Are you thinking what I'm thinking?  ;)

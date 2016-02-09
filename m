From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/2] cyclictest: Add --smi description on cyclictest man
 page
Date: Tue, 9 Feb 2016 15:16:09 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1602091515490.7299@riemann>
References: <cover.1453397401.git.bristot@redhat.com> <febe80773c6c45fca3497bb97094c52d76bbf37b.1453397401.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	Len Brown <len.brown@intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36355 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288AbcBIOQM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2016 09:16:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id 128so3672245wmz.3
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Feb 2016 06:16:11 -0800 (PST)
In-Reply-To: <febe80773c6c45fca3497bb97094c52d76bbf37b.1453397401.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 21 Jan 2016, Daniel Bristot de Oliveira wrote:

> Add the description of the --smi comand line option of cyclictest.
> 
> "--smi  Enable SMI count/detection on processors with SMI count support."
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  src/cyclictest/cyclictest.8 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 4e169aa..437e7a6 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -188,6 +188,10 @@ memory allocations using the numa(3) policy library. Thread stacks and
>  data structures are allocated from the NUMA node local to the core to
>  which the thread is bound. Requires the underlying kernel to have NUMA
>  support compiled in.
> +.TP
> +.B \\-\-smi
> +Enable SMI count/detection on processors with SMI count support.
> +
>  .SH SEE ALSO
>  .BR numactl (8),
>  .\" .br
> -- 
> 2.5.0
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>

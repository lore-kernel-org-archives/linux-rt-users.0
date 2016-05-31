From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: new CPUs with SMI counter support
Date: Tue, 31 May 2016 10:47:39 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1605311043460.6356@riemann.home>
References: <8cbc61e6bb66eaca972e9697ae38c4d23e193e09.1464644578.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35174 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbcEaIrs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 May 2016 04:47:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id e3so30235505wme.2
        for <linux-rt-users@vger.kernel.org>; Tue, 31 May 2016 01:47:48 -0700 (PDT)
In-Reply-To: <8cbc61e6bb66eaca972e9697ae38c4d23e193e09.1464644578.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 30 May 2016, Daniel Bristot de Oliveira wrote:

> Cyclictest's SMI counter implementation is based on turbostat's
> implementation. This patch syncs cyclictest's has_smi_counter()
> with turbostat's check.
> 
> From turbostat's commits:
> cdc5727 tools/power turbostat: initial KBL support
> ec53e59 tools/power turbostat: initial SKX support
> e4085d5 tools/power turbostat: initial BXT support
> 
> [ John & Clark, I did it in the branch devel/v2.0, but we need  ]
> [ this in the 0.x and 1.x series as well.                       ]
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 00e5f3d..5e23fc5 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -927,10 +927,14 @@ static int has_smi_counter(void)
>  	case 0x56:      /* BDX-DE */
>  	case 0x4E:      /* SKL */
>  	case 0x5E:      /* SKL */
> +	case 0x8E:      /* KBL */
> +	case 0x9E:      /* KBL */
> +	case 0x55:      /* SKX */
>  	case 0x37:      /* BYT */
>  	case 0x4D:      /* AVN */
>  	case 0x4C:      /* AMT */
>  	case 0x57:      /* PHI */
> +	case 0x5C:      /* BXT */
>  		break;
>  	default:
>  		return 0;
> -- 
I applied the patch to both the stable and devel branches. I slightly 
modified the commit message to read.

"    Cyclictest's SMI counter implementation is based on the turbostat
    tool in the Linux kernel.  This patch syncs cyclictest's 
    has_smi_counter() with turbostat's check.
"

Signed-off-by: John Kacur <jkacur@redhat.com>

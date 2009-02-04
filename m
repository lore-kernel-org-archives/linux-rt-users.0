From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
	possible
Date: Wed, 4 Feb 2009 22:26:12 +0100
Message-ID: <20090204212612.GN22608__12562.5090943233$1233782920$gmane$org@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Sam Ravnborg <sam@ravnborg.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756494AbZBDV0y@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090204150835.GA30027@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch gives arches more freedom on overwriting CFLAGS, specifically
> on PowerPC we want to remove -fno-omit-frame-pointer flag.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7715b2c..d1ba93f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -525,8 +525,6 @@ else
>  KBUILD_CFLAGS	+= -O2
>  endif
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
>  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
>  endif
>  
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> -- 

this patch is really for Sam to judge - Cc:-ed him.

	Ingo

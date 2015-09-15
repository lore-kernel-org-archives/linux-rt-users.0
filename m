From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 8/9] error: mark fatal, err_exit, err_quit as
 being noreturn
Date: Wed, 16 Sep 2015 00:31:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509160030270.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <0e671c826ca8281e8ad005a9dbc4f553cc816e8d.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37154 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbIOWbS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 18:31:18 -0400
Received: by wicfx3 with SMTP id fx3so46378563wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 15:31:17 -0700 (PDT)
In-Reply-To: <0e671c826ca8281e8ad005a9dbc4f553cc816e8d.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> These functions never return to their caller.  Mark them as such to aide
> in code generation and help out static analysis.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/include/error.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/include/error.h b/src/include/error.h
> index ae05a2e..4acff49 100644
> --- a/src/include/error.h
> +++ b/src/include/error.h
> @@ -6,14 +6,14 @@
>  #include <stdarg.h>
>  #include <string.h>
>  
> -void err_exit(int err, char *fmt, ...);
> +void err_exit(int err, char *fmt, ...) __attribute__((noreturn));
>  void err_msg(char *fmt, ...);
>  void err_msg_n(int err, char *fmt, ...);
> -void err_quit(char *fmt, ...);
> +void err_quit(char *fmt, ...) __attribute__((noreturn));
>  void debug(char *fmt, ...);
>  void info(char *fmt, ...);
>  void warn(char *fmt, ...);
> -void fatal(char *fmt, ...);
> +void fatal(char *fmt, ...) __attribute__((noreturn));
>  void err_doit(int err, const char *fmt, va_list ap);
>  
>  #endif	/* __ERROR_H */
> -- 
> 2.5.0
> 
> --
Signed-off-by: John Kacur <jkacur@redhat.com>

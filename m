Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813F2C43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C654218A2
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553347045;
	bh=FjwV6yy8jZo7U7CXAoZyQvyklUkvn/BZaZo6XEtq0nY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=FQ8dWkjyb1RVasU5Z23KWkvmPUg7hko/II4E5buni5sZXhhcg0aMF1aiH0qx5DTEf
	 q49uG5q5GyYhywBe+HolXjR1PxAE6Ny4t/hB1LCYrPO7DG2OXipy6LrLfW29iFkGws
	 /SvJbB7ytvmpVrmAoD854HYOf+MASMU6vAJdNYyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCWNRZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCWNRY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 09:17:24 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF5E2175B;
        Sat, 23 Mar 2019 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553347043;
        bh=FjwV6yy8jZo7U7CXAoZyQvyklUkvn/BZaZo6XEtq0nY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qWlcwvYYXwiiVWLpvMnoOVy5kHBRNPEHVLKAzmSBT/YYl0wAlQNBw+azh3Hgi9cM0
         RT81BOQxmfLieVEociLWmvRVaBdYyopGVDI4SkJ9+96VKrxpbBug47YyByAbqhn3ov
         pZRV3wgYwgS1ryOpizegzV0c4gYIB60qVpEvrXWo=
Message-ID: <1553347041.2307.13.camel@kernel.org>
Subject: Re: [PATCH v4 08/11] selftests/ftrace: Add tracing/error_log
 testcase
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Sat, 23 Mar 2019 08:17:21 -0500
In-Reply-To: <20190323210816.5cc19aa0d7c43c4c19c639b8@kernel.org>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
         <a0b936b8ba26b6c55bddc7d5ec22fc40e49a77b9.1553268041.git.tom.zanussi@linux.intel.com>
         <20190323210816.5cc19aa0d7c43c4c19c639b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Sat, 2019-03-23 at 21:08 +0900, Masami Hiramatsu wrote:
> On Fri, 22 Mar 2019 10:34:34 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a testcase verifying basic tracing/error_log functionality.
> 
> Would you be OK that you don't test all error cases with
> error position?
> 

Good point - I'll add checks for error position in my testcases too.

Thanks,

Tom

> Thank you,
> 
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../ftrace/test.d/ftrace/tracing-error-log.tc      | 23
> > ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-
> > error-log.tc
> > b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> > new file mode 100644
> > index 000000000000..601ffebfbb9f
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-
> > log.tc
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: ftrace - test tracing error log support
> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +# event tracing is currently the only ftrace tracer that uses the
> > +# tracing error_log, hence this check
> > +if [ ! -f set_event ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +echo "Test tracing error log support"
> > +! echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" >
> > events/signal/signal_generate/filter 2> /dev/null
> > +if ! grep "error:" error_log; then
> > +    fail "Failed to generate tracing error log error"
> > +fi
> > +
> > +exit 0
> > -- 
> > 2.14.1
> > 
> 
> 

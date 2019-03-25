Return-Path: <SRS0=5pzl=R4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D6BC43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055220830
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 14:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfCYO2b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYO2b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Mar 2019 10:28:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD14720863;
        Mon, 25 Mar 2019 14:28:29 +0000 (UTC)
Date:   Mon, 25 Mar 2019 10:28:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 04/11] tracing: Use tracing error_log with trace
 event filters
Message-ID: <20190325102828.0c778538@gandalf.local.home>
In-Reply-To: <20190325111724.GB211529@google.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <f0895856a61d95aba80f9668d6828234d33b5d7c.1553268040.git.tom.zanussi@linux.intel.com>
        <20190325111724.GB211529@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 25 Mar 2019 20:37:23 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> >  /* Called after a '!' character but "!=" and "!~" are not "not"s */
> >  static bool is_not(const char *str)
> > @@ -947,8 +948,10 @@ static void append_filter_err(struct filter_parse_error *pe,
> >  	if (pe->lasterr > 0) {
> >  		trace_seq_printf(s, "\n%*s", pos, "^");
> >  		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
> > +		tracing_log_err("event filter parse error", filter->filter_string, err_text, pe->lasterr, pe->lasterr_pos);
> >  	} else {
> >  		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
> > +		tracing_log_err("event filter parse error", filter->filter_string, err_text, FILT_ERR_ERRNO, 0);  
> 
> These lines are too long, could you please wrap?

Agreed.


> Otherwise, the whole series look good to me.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung!

-- Steve

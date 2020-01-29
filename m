Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4846BC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF2207FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 21:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgA2VJR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgA2VJR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 16:09:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962E320674;
        Wed, 29 Jan 2020 21:09:16 +0000 (UTC)
Date:   Wed, 29 Jan 2020 16:09:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 07/12] tracing: Add synth_event_trace() and related
 functions
Message-ID: <20200129160915.4ebe0f08@gandalf.local.home>
In-Reply-To: <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 29 Jan 2020 12:59:27 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +static struct synth_field *find_synth_field(struct synth_event *event,
> +					    const char *field_name)
> +{
> +	struct synth_field *field = NULL;
> +	unsigned int i;
> +
> +	for (i = 0; i < event->n_fields; i++) {
> +		field = event->fields[i];
> +		if (strcmp(field->name, field_name) == 0)
> +			return field;
> +	}
> +
> +	return NULL;
> +}

Why duplicate all theses functions and not use them in the
synth_event_trace() directly?

-- Steve

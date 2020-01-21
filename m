Return-Path: <SRS0=QguH=3K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA9C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A7121569
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAURDu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgAURDu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jan 2020 12:03:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C75A21569;
        Tue, 21 Jan 2020 17:03:49 +0000 (UTC)
Date:   Tue, 21 Jan 2020 12:03:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 07/12] tracing: Add trace_synth_event() and related
 functions
Message-ID: <20200121120348.01399a47@gandalf.local.home>
In-Reply-To: <fde7210e7807c29783fff0e2a06d0561d810c7cf.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
        <fde7210e7807c29783fff0e2a06d0561d810c7cf.1578688120.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 10 Jan 2020 14:35:13 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +struct synth_event;
> +
> +struct synth_gen_state {
> +	struct trace_event_buffer fbuffer;
> +	struct synth_trace_event *entry;
> +	struct ring_buffer *buffer;
> +	struct synth_event *event;
> +	unsigned int cur_field;
> +	unsigned int n_u64;
> +	bool enabled;
> +	bool add_next;
> +	bool add_name;
> +};
> +

Yes, please rebase on my for-next branch, as the ring_buffer structure
has been renamed, and will break these patches :-/

-- Steve

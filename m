Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C646C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47141214D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA2CPF4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgAaSBY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:01:24 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34321 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSBY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 13:01:24 -0500
Received: by mail-il1-f195.google.com with SMTP id l4so6918958ilj.1;
        Fri, 31 Jan 2020 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPtqEjxnKtkoTP5gb2lPGySEQWTilXutlPvMvhSkzB8=;
        b=KA2CPF4eRl7yvouPfDHAc8MVDYczeN4kvJJZaZgeqVVqzLUnRDuBJa7+VCLwoazucb
         IRRVFhEOd/5xgV6g0Y3fheDtooFAw19zxNHF7BK/8BrynVyZ0apbAbQH/Zvz070WSCYN
         WJdTjyWps4J7XaFn0/3EpUQkQttYlQSZZPcaccoxXrP9Oerrad6NbzJH7s9qcikPD+J2
         ogUIX5SPW0OfE1NYdZJnh5BjRcwLylqxSh7j+/3ObCyU+4WxfmaT/2Nm/XgmNl2uJT+R
         pOqU1baIFwmS3RsAEt59XeVZqgbchWkmUF3XyKHEu+Z0GrYP9ywF4hBo5miM81Ycieto
         J4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPtqEjxnKtkoTP5gb2lPGySEQWTilXutlPvMvhSkzB8=;
        b=ArvuLkiJcwWSbR0XSneCz6Ci/sxWrs6rKuWxsvg1oNsTLCqdIC180g2vFGgu/ak962
         n/zJRBhWvp8QnwN91gD+ojgvENQgoja//yfbBnJRz107K4KQ+KReAqVb01cbMabJuGcE
         +cLVsKbfEpz0SUE9AzgGFjobaWjo6wCgqFI8WPGbOI47S/XT5FsAwPhDr9PZF54q0WMy
         dh4+9k0xjeoAyqKs0NDnp/GaUpqokhrKbcZ/IlB/JiflrA1jwAkXkrKUGUXoDBIgD63s
         IwzTK3WH6GthUntTguBkAnqqqMGNs9tA19zwgyZIeF2WZeSzA0Y1hqC2A+hLQVIHDHrq
         sb+w==
X-Gm-Message-State: APjAAAUnKAU/N1p9JKRI9Nxt4qx5mMKTwuVedLJqIc/Rkj62waxvSWLs
        V+2ENhb8sws1gwH2ZtFwCNQ=
X-Google-Smtp-Source: APXvYqzVJDjpZd0RBibJkBOlYS0/M2Rz4oXKuLe0qZs5WdKOVZhG5Hq46U0xB7V74zU9CrQ058QPDg==
X-Received: by 2002:a92:9e97:: with SMTP id s23mr4054358ilk.139.1580493680666;
        Fri, 31 Jan 2020 10:01:20 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:3:ceb0:d4c1:8f5f:7b14:ce46])
        by smtp.googlemail.com with ESMTPSA id b4sm3416567ill.24.2020.01.31.10.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 10:01:20 -0800 (PST)
Message-ID: <1580493678.24839.6.camel@gmail.com>
Subject: Re: [PATCH v4 06/12] tracing: Change trace_boot to use synth_event
 interface
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 31 Jan 2020 12:01:18 -0600
In-Reply-To: <20200131130020.51d04203@gandalf.local.home>
References: <cover.1580323897.git.zanussi@kernel.org>
         <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
         <1580492941.24839.5.camel@gmail.com>
         <20200131125539.68ab766d@gandalf.local.home>
         <20200131130020.51d04203@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2020-01-31 at 13:00 -0500, Steven Rostedt wrote:
> On Fri, 31 Jan 2020 12:55:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 31 Jan 2020 11:49:01 -0600
> > Tom Zanussi <tzanussi@gmail.com> wrote:
> > 
> > > Hi Steve,
> > > 
> > > It looks like you missed this patch when you pulled the other
> > > ones into
> > >  for-next.
> > >   
> > 
> > Ah, you're right! And my INBOX patchwork is informing me of it too
> > (I
> > have it read my email, and when I post the 'for-next' patches, it
> > switches the status from "new" to "Under review", and this one is
> > still
> > "new").
> > 
> > Thanks for letting me know. I'll apply it now.
> 
> My latest has been pushed to ftrace/core.

Thanks!

Tom

> 
> -- Steve

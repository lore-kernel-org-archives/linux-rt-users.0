Return-Path: <SRS0=P/LD=UL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7459C31E46
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jun 2019 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8B320896
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jun 2019 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyY369AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfFLRCF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:02:05 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37631 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfFLRCF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jun 2019 13:02:05 -0400
Received: by mail-ot1-f47.google.com with SMTP id s20so1808687otp.4
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jun 2019 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V4ANgi+/W6bBbMYqmS4Z9ZiOnWCajk77GKEngPhv9/o=;
        b=QyY369AViOy6bpdXtBFucgFIBfOWbOe8BwIc93fzOC4j2w+oHOZh8mVCD5crJiFxCh
         NZIz5FL0R5Q/mIaJLTLklzaxwA/RDpMkvO6DvBy5PXfIxl644pizsm2a5zIk6TnpT1WE
         s3XQi+yFKzIcA5x+6+yhBNmPCNkxWg8Rek8oxN136Df5NC96tLSpbWDj/L05asU6LIkr
         gV3PhnuhkXr4LyYAnUX4E0Q5lv2sYpzO/dcbwogK+RZru430Br4b5PVT+iaVbH9h3hRL
         yjtdaEZ/6s9arjGMVgr8n124ku5IAuou98eV2woQTiubqt6R3L5mpcfSlHTISqN5zuNQ
         FiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V4ANgi+/W6bBbMYqmS4Z9ZiOnWCajk77GKEngPhv9/o=;
        b=texBdNJ10yuEwesiYjzoxdlGmjxdKeQm/7zfuIvT33lu+97KRUpydAVPwTyTE4qlZ2
         PpEDb15EMcG/PXi5p/+N9swOoEW7AgoWH7+hsbEm4mtr3kUeS8lXqdNlx+1fbrtBPRff
         FomaOMpMVCt2WWtDHjFV2Juea23VSQfk0J7UWYHi/8vW0QrjMB0WTF28WON6nDnRpU/p
         iaPaJZ/ebzf//8CpSGE5/xZ6Q03fwevMU+ir5gi+bUwOT89GVC22vbdhwlqZ9L3zrVzx
         9qigMONQqFDGZO4LyRKqaRJTVWtYXDvTpHzx+85S/nC1RbisbnZojSsE3NJKVDtd1c6E
         AokQ==
X-Gm-Message-State: APjAAAWMRv8iTJJyn4fQmcHdRS5GkVVtoowi7ptnGl89JUz/9rbK8l3P
        W1YqAsPxFDfxFVHdmiBmhOx0qmlQYLvaZGZGR2wdmurnZvE=
X-Google-Smtp-Source: APXvYqz22ovut+MlTGN3nv5jEe5DZpHmeRVQA6IzqQ1CCOo1AHac2CyT41vswrmxn/AiTBz/ze27DaCi+zb33Iil4w8=
X-Received: by 2002:a05:6830:1009:: with SMTP id a9mr25840021otp.331.1560358924183;
 Wed, 12 Jun 2019 10:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
 <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com> <CAM5Ud7O2OtDLdJPArAAfw7A1xBm89dBSXk64vYsb-KY9N5RXUw@mail.gmail.com>
In-Reply-To: <CAM5Ud7O2OtDLdJPArAAfw7A1xBm89dBSXk64vYsb-KY9N5RXUw@mail.gmail.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Wed, 12 Jun 2019 12:01:46 -0500
Message-ID: <CAM5Ud7MTfpyv4ajVkuoe+_pjvq0t1ZWAGUUukrDK+xf5Rx0qiQ@mail.gmail.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
To:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

EFI Stub is working now, thanks again. Latency isn't affected by EFI
on this particular board (ASUS TUF B450M-Plus Gaming) with Ryzen 2200G
and BIOS version 1003 (dated 2019/04/30 -- Latest as of this writing.)

Alec

On Mon, Jun 10, 2019 at 9:47 PM Alec Ari <neotheuser@gmail.com> wrote:
>
> Hi,
>
> Thank you, Scott! That explains everything, appreciate it! I wanted to
> do latency testing with PREEMPT_RT under EFI and couldn't figure out
> what I was doing wrong.
>
> Alec

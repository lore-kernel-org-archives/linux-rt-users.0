Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5AEC7EE2D
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Mar 2023 17:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCCRRQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Mar 2023 12:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjCCRRB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2023 12:17:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD1305E5
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Mar 2023 09:16:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so13059904edy.8
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Mar 2023 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677863816;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIWq/HdkpUCG+sn3M/u0ziZmzHOi0pl/yDgomWY5tSA=;
        b=Nw49rCtwSQbL8Zl8xlIZ/7y8tvgVez+hG8iplp7MqzwfzkEJ7cBzJMJPkQlw3QGXwi
         tcL7B8FUSGxzfyeGClKRldgxq+Rnkyc/JxDCmjAbIiSk/QqL0sGBY5QzUr+DiqbMGqqb
         SyjStP/AM/ORsu73oXbbviy/a7tf3QxzLRLOtMftcKauvr8VMyzpDCw8KMnyfsUIisuh
         6b8akwl6AsvBxUngvCpGbRE4sFKfbovrkjv1gakDb0FGkjP8tP80LbCUgoFajwQZxBk8
         YVk9F3lB/eG8H2jkYYOO1wu+SLbZ0YvQqokskfVNDiXt8rRohPkXCqfaIxu5juL5GQOA
         gh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863816;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIWq/HdkpUCG+sn3M/u0ziZmzHOi0pl/yDgomWY5tSA=;
        b=70joIyzFen0yFUVSl8Gcg7p4XLXR4QWsM3YcAmh9aFEeXtSZavtMBXPwh5n1TzdkXd
         wGvn1AhSAnsd+8sN3Lo15tCYVGhbQcBvgqnK25Zi4zp0yK7JVsMmzbV7adt3WAEFMFpt
         TzCADl7AvChybF9BEfj3St/e4GmeTaXlQyAsnPoAc1bkD+rf0J7SxZINTqS+1wghitYk
         Fbb+mbYwc6rLsQbW4ibHmbQiCJ5KocZQWCY2ujT150CJ/hyaglXH1dqokl7Xi6UA4VDi
         JzU6uDGNm5HEnQu9TtelvFOXF+aGi9V0ybeMLqWQlMWVef6V5pbpgzlqsSS9N+4e8Jgk
         UKQg==
X-Gm-Message-State: AO0yUKUWs6IsWymD/RP+iWvEl1jMJB5dasYrP862U0vhK4Es7OrZaakI
        ar+F0VKqcZYhFn2ndHQ2k+K1OMTQHDEZCJsJedRuGp1Mnp4=
X-Google-Smtp-Source: AK7set9GkuS523wvvsHj/O/tDDqTDU0qin3gkSnuUAEAIqxXycVII8CS8zjsVXsIxq2AW+UOIct3gpoUnqe4e8JP7yY=
X-Received: by 2002:a17:906:2a55:b0:8b3:1041:1d08 with SMTP id
 k21-20020a1709062a5500b008b310411d08mr1178207eje.7.1677863816582; Fri, 03 Mar
 2023 09:16:56 -0800 (PST)
MIME-Version: 1.0
From:   Aaron Simmons <paleozogt@gmail.com>
Date:   Fri, 3 Mar 2023 10:16:46 -0700
Message-ID: <CAAajkiYTEvxpV_Vg6rj6es=rJEidNEpEgWciY2TNqRqzVmb1MQ@mail.gmail.com>
Subject: preempt-rt + live patching + arm64
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm trying to bring preempt-rt into a kernel that has had
live-patching for arm64 applied.  Specifically, this patch:
   https://lkml.org/lkml/2021/6/4/1169

There's a conflict in some definitions of arm64's thread_info.h:
    ++<<<<<<< HEAD
    +#define TIF_PATCH_PENDING     7       /* pending live patching update */
    ++=======
    + #define TIF_NEED_RESCHED_LAZY 7
    ++>>>>>>> 3fc990649e4f (PREEMPT_RT 5.15.93-rt58)

It appears that the TIF_XXX range is getting crowded. :)

Resolving the conflict seems straightforward -- I should just give
TIF_NEED_RESCHED_LAZY a new value.  But I wanted to double-check --
does the range of these values matter?

I see over in 32-bit arm's thread_info.h a comment about the "range of
0..15" being important, but I'm not sure if that applies to 64-bit or
not.


Thanks,
aaron

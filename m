Return-Path: <SRS0=z+Xj=64=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11ECC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 May 2020 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47BE20727
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 May 2020 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589467729;
	bh=ock2AdPvW3aEpHYhbA807CxORy4d+uAYR8Z3z0CJ2h8=;
	h=From:Date:Subject:To:List-ID:From;
	b=UcgHmSecTiO9jbn3xwUz0fG4qg/ypapxZDnygWDDSFUb4+8AtZlouIuV2UKBwZwl2
	 w9PcAh0OFEKAs+gsFlr9ZYQp/55NTOwGzWax82mpbd5DB8QMR1mqFXO7xzTwQRU00a
	 AaYv6nydCjlkPKFytE/59NAc5wWbBtcFWsxryR9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgENOst (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 May 2020 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgENOst (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 May 2020 10:48:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A7C061A0C
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2020 07:48:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h188so2126972lfd.7
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2020 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=K2F5XZn9Z3hanNghTZPPc4IerVw8qcWBS8DkRbfKv/I=;
        b=hg/5YMwdX0ChFGh1EUArs5o2FdL5NRaUI67ZLwYRLIbC6PbqCRJVUWoZzLI3V7f9c+
         o53k4Kc+e2kw/r7S7IM/c2QJzRPgoGIgpcnmMm/pa/kQgO5tjCbMaS66EqxdRTXI3Zv5
         8cu52lpgedhyBLSapYR7dJqWuS2+bt1DvQWeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K2F5XZn9Z3hanNghTZPPc4IerVw8qcWBS8DkRbfKv/I=;
        b=ivzWN2rhq4RXWNLr/U3DN6CmKIj0trRRtxwN1Mmnvgd2Z0u4ZJ63XMDx6KcQCdOPtZ
         SmqoUzHRTL+yJl/KzOQ2stVao8nfNQtE4r6kqZ96r5+fJ7EIXv7IP4YLi82c5o4y1B4m
         83IAIygyGl6fpS9LNrhiJVQ27Md7hKFD2mStFbgbW9pSvXExDWdnAArASDA6EKiSI8TL
         o0eOl/YLlWqDzq9YLnduzDtNGJdUiVdQjCKc/wKk10UqqpaQvFrwnngBSR82rPvOvwcv
         dd90pn0CAEZny8toeHqpJSi/j2Uz6M8lpGYQMBcZsynzOm0umd60j4/+deLENGGsR9Ia
         QjaQ==
X-Gm-Message-State: AOAM531s+y8n9T/7WcsTlfXunWr4ar97izDKWKAMzVtW0Fgr118m7UGc
        g+YNuP9h0NOcu4m7N1XC7QrHzMCHUV3omtiNxMMMNAsJiAc=
X-Google-Smtp-Source: ABdhPJx+Z20oDbNzjJZBqOobx3mERu6i9JXya2Y0YmYiKh7ZDZCwA90kdZ/H057qAgRlXng0h1s+ECwTOUXAoO7XDTw=
X-Received: by 2002:a05:6512:53a:: with SMTP id o26mr3589548lfc.111.1589467726814;
 Thu, 14 May 2020 07:48:46 -0700 (PDT)
MIME-Version: 1.0
From:   Kate Stewart <kstewart@linuxfoundation.org>
Date:   Thu, 14 May 2020 09:48:36 -0500
Message-ID: <CAG_66ZSJ6OUs3eq4UihqeW4KpDR7Mken5aQCEJ3UaAhZaMJzuQ@mail.gmail.com>
Subject: ELISA workshop next week - signup by Friday May 15th
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
     Since there are some members of the Real Time Linux community
with a focus on using Linux in safety critical applications, I just
wanted to flag that the ELISA workshop next week is being held on-line
instead of in-person and may have some sessions of interest.

     The workshop is free to attend, but you do need to sign up for
the sessions you'd like to participate in.     Overview of the actual
session can be found at:
https://elisa.tech/announcement/2020/05/13/collaborate-virtually-at-elisa-may-workshop/

Sign up at: https://www.surveymonkey.com/r/25NB38Y.  Link for sign up
will remain open until 5pm EDT on Friday May 15th.

Thanks,  Kate

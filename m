Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB78C2B9F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Jun 2021 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855D761921
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Jun 2021 21:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYVhN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVhM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Jun 2021 17:37:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6CC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2021 14:34:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s19so14179562ioc.3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jun 2021 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpVK40GwlNlxs6/N2wwBl7Uu4Iqou5jJOX/CREiXNqI=;
        b=saTih9ey1PyFEKS9Y1m0q9PQ9+7yw2B31l1+DR9as0KFNhRZnQWT4/Z02b4TDk58HT
         ZtXiQgaGec2lCezwyKwNg/WLLcErhnoex/2N7typtYWYNtzmu19mEscLylof25yQrir2
         ikIccJN6XqFDtl606DNMhQsi2+Zp+PR5fIyNzmVV9SlvoAWumvSo5fscjLrwOYcnpiq/
         DLiWBioZ/usDFFeT4Jh6oiqbj7Kl9LpkVPQTjYJujCIFZpbwYvtCO5Mfaxk2+dOH6llh
         koeRBMfM5mExkvs02OkXKLnCkPYkU9Z4qmT+2KgjBF5l1STcdR/6KUBuZXuoYOIfsKnc
         Ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WpVK40GwlNlxs6/N2wwBl7Uu4Iqou5jJOX/CREiXNqI=;
        b=rucJC9mAOqhzC98+546d8CKgdmwvMqguHG+V7LLS1Lj9A5rwvoC78L0GhoxVnanY/5
         x69bcgzXtlg61MeLFYA1RKITvmwr7Ane8P6+CWIS2gnnNyK+zmqL3w0Ue6uIM9kcGUMb
         F+P9WE3KqXUezdrDn6OHhyCxj0tMSANnNQlEwd89bS9MllkNAwrdlrEPLmy9U0vs8xli
         cb10MA2aOxuauLUByH3CXEfMnKO7caR10I0s1bwg3fWLmp+TkUmMMynSOljnYqp9SmAO
         buXUZtdbhvq6agL9sWSiVDH3vnbUJhLyuuzgh9sOd4GEmrU/zflcGnVBzKt3+tzVIker
         RL2A==
X-Gm-Message-State: AOAM533DkejbrtHlUt440g5/WrKNPrxQBeymR02q+fQub6P8SOtQaU/t
        7G3GMdYxBfaeHm2wnK5ZiR8=
X-Google-Smtp-Source: ABdhPJw4UvjKNw3WQuzpCbj4zYUcVCLgG7gSzz+WlC0uZAIUH+y80qTTc6k7R5qxHQn0V+zODK16sw==
X-Received: by 2002:a02:5e8a:: with SMTP id h132mr8658951jab.60.1624656890504;
        Fri, 25 Jun 2021 14:34:50 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-18.dsl.bell.ca. [184.147.142.18])
        by smtp.gmail.com with ESMTPSA id n12sm4006476ile.0.2021.06.25.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:34:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     tuna-devel@lists.fedorahosted.org,
        RT <linux-rt-users@vger.kernel.org>
Cc:     Jiri Kastner <cz172638@gmail.com>,
        Federico Pellegrin <fede@evolware.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] tuna-0.16
Date:   Fri, 25 Jun 2021 17:34:36 -0400
Message-Id: <20210625213436.16143-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce tuna-0.16

Thanks to Federico for coming in and completing the work to fix the gui
after the port from gtk2 to gtk3. We now have a working tuna gui as well
as oscilloscope!

I have renamed the master branch as the main branch and made the main
branch the default as part of the community's conscious language effort.

Bug reports, testing, patches are always appreaciated.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://kernel.googlesource.com/pub/scm/utils/tuna/tuna.git

Branch: main

Tag: v0.16

Tarballs are also available here:
https://kernel.org/pub/software/utils/tuna/

Older version tarballs are available here:
https://kernel.org/pub/software/utils/tuna/older

Federico Pellegrin (21):
  tuna: multiple fixes for Gtk-3.0 UI interface
  config: make configuration files consistently text only
  profileview: disable cursor_changed handler when manipulating list
  cpuview: a few more improvements for Gtk 3.0
  tuna_gui: handle destroy handler to prevent error messages on startup
  tuna: fix mnemonic accelerators for Gtk 3.0
  profileview: fix text entry retrieval
  cpuview: improve display of CPUs/Sockets for every CPU/socket number
  sysfs: correct and improve sorting
  oscilloscope: complete porting to Gtk 3.0
  cpuview and util: add missing os import
  irqview, procview: spins in Gtk 3.0 need to have range defined
  procview: fix logic of refresh and attributes dialog display
  tuna_gui: remove unused signal to prevent errors
  procview: fix another identation error
  procview: fix perf watch and add handler for errors
  tuna-cmd: fix command line when inet_diag is present
  tuna_gui: add command line option to customize GUI refresh time
  procview: fix thread refresh when using polling mode
  procview: limit refresh rate in perf mode to refresh_time
  tuna_gui: add command line option to explicitly disable perf usage

John Kacur (4):
  tuna: Fix tuna --include option breakage
  tuna: tuna add gui refresh option to the manpage
  tuna: Correct allowable ranges in irqview and in procview
  tuna: release 0.16

 docs/tuna.8             | 12 +++++--
 oscilloscope-cmd.py     |  2 +-
 setup.py                |  2 +-
 tuna-cmd.py             | 26 +++++++++++---
 tuna/config.py          |  4 +--
 tuna/gui/commonview.py  | 13 +++----
 tuna/gui/cpuview.py     | 34 +++++++++---------
 tuna/gui/irqview.py     | 12 ++++---
 tuna/gui/procview.py    | 79 ++++++++++++++++++++++++-----------------
 tuna/gui/profileview.py | 19 ++++++----
 tuna/gui/util.py        |  1 +
 tuna/oscilloscope.py    | 41 +++++++++++----------
 tuna/sysfs.py           | 10 +++---
 tuna/tuna.py            | 10 +++---
 tuna/tuna_gui.glade     | 10 +++---
 tuna/tuna_gui.py        | 14 ++++----
 16 files changed, 170 insertions(+), 119 deletions(-)


From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Mon, 4 Jan 2016 07:39:04 -0600
Message-ID: <20160104133903.GG92593@unpythonic.net>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: Khem Raj <raj.khem@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zaphod.unpythonic.net ([76.79.27.186]:14644 "EHLO
	zaphod.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcADOXV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 09:23:21 -0500
Content-Disposition: inline
In-Reply-To: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I believe the patch does not have the desired effect, because make(1)
always sets CC automatically:

$ cat raj.mk
CROSS_COMPILE=x86_64-linux-gnu-
CC?=$(CROSS_COMPILE)gcc
.PHONY: default
default:
	@echo CC=$(CC)
$ make -f raj.mk
CC=cc

With your patch, those who specify CROSS_COMPILE, or for whom gcc and cc
are different, will get different (worse) behavior.

I believe this idea has been discussed before, but it is hard to search
for because few search engines will let you search on "CC ?=" and not
just ignore the "?=".

Also I am not sure why you are submitting this patch on -rt-users, it
doesn't seem to be particularly relevant to the RT patchset.

Jeff

From: Gregory Haskins <ghaskins@novell.com>
Subject: [RFC PATCH 0/2] sched fixes for suboptimal balancing
Date: Wed, 23 Apr 2008 07:13:24 -0400
Message-ID: <20080423111313.4981.37345.stgit@novell1.haskins.net>
References: <480DDC48.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:44305
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751604AbYDWLq3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2008 07:46:29 -0400
In-Reply-To: <480DDC48.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,

Here are my proposed fixes for the issue Dmitry has highlighted in:

http://lkml.org/lkml/2008/4/22/296

This is an RFC, and it applies to sched-devel.

Regards,
-Greg

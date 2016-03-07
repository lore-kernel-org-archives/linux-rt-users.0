From: Henning Schild <henning.schild@siemens.com>
Subject: regression in rt patches
Date: Mon, 7 Mar 2016 18:28:25 +0100
Message-ID: <20160307182825.3647f443@md1em3qc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:36629 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcCGRlu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 12:41:50 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey,

this patch out of the current 4.4.3-rt9 series
"trace: Use rcuidle version for preemptoff_hist trace point"
introduces a regression where the kernel wont compile for a
configuration without trace histograms

Ammend to following to the patch to fix it:

--- a/include/trace/events/hist.h
+++ b/include/trace/events/hist.h
@@ -9,6 +9,7 @@
 
 #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
 #define trace_preemptirqsoff_hist(a, b)
+#define trace_preemptirqsoff_hist_rcuidle(a, b)
 #else
 TRACE_EVENT(preemptirqsoff_hist,


Henning

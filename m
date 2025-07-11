Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864529B220
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jul 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237338; cv=none; b=ipmRkZtOFl6kDEOqid+JYI7iBlt3FXZPKE1Xmr9sWewNFol5GKlDpfPq7PSyjrwHJbM5z5q7He69gHjK07oGmaAx1gn5t2TTWoPa7eRlE+Aamz2j3NYOSqZnOxUX0k8ZWQnQP8igsCcrVaX2FaS9Hd+u4Sr1WzRPZfx945hvIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237338; c=relaxed/simple;
	bh=RjkSdEVpeSrzpN8Ht6j6XIPzWqJyjTMgQemB9y+9mgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obs7/3/JMQjTPs/ZeNE/0S0ar9N12zY9M/+oRhOBTpKLckXb8OCPlFN6gGGZbnvs2i8/e6TZM9nxw7Gl1sHS3l9u2X2GVU9+rIlfRB7dsk15Jh6Q/uT3TSexayJThIYb6muezLhXEBnmLh4B/0pOI2b25Culn1aJfBy2fTBK/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoAhC6lv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoAhC6lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752237337; x=1783773337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RjkSdEVpeSrzpN8Ht6j6XIPzWqJyjTMgQemB9y+9mgU=;
  b=YoAhC6lv38CLIClWT5HQ938z549GhX+OOs19wXuFMk6mWeKLL3JMc2Gj
   5EXESjuvlSnh6eztDMoLJtHk4ebiP0z3URHuR/mbJaWcRH+KCUwVAqKMn
   kICkFLKNMEDM3Klc1VAoFWy+28w3JBn3QjVCcr3inyR0N+GwudE5aYdx8
   T7Vhes2kncsHY3JuVrab9sE1uUSMotNnzOqBG9YyZgUuxOICmUP8RSX4h
   o2Ep/WY7QnAh87YdEGxv+ImnLcUPfwjX0PwuqgPJ6bFQD9EFbmMsCqCGb
   4P6UxG71odRwBZp23cD1rnR8XcM6FXKmInl9KYynfCfFke8ez7yoVg+pz
   w==;
X-CSE-ConnectionGUID: 8I8/AKbfReWDrb4907ny8A==
X-CSE-MsgGUID: 1jOYKkykQeKja0/K0ScOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54663737"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54663737"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 05:35:37 -0700
X-CSE-ConnectionGUID: deWF5A4MT8C28g6N5FtpfQ==
X-CSE-MsgGUID: U1B8dxmVQ5KdJA3spNobnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="187340619"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.245.61]) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 05:35:34 -0700
Message-ID: <2d4a5031-307d-4f29-8875-13b8b599b220@linux.intel.com>
Date: Fri, 11 Jul 2025 14:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PREEMPT_RT vs i915
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com> <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com> <20250710064136.rur6FoOU@linutronix.de>
 <aG_VzpXaYRCQQGYt@intel.com> <20250710152008.ZyaHjC3w@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20250710152008.ZyaHjC3w@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

On 2025-07-10 17:20, Sebastian Andrzej Siewior wrote:
> On 2025-07-10 18:04:42 [+0300], Ville Syrjälä wrote:
>>
>> When this was last discussed I suggested that there should be a
>> versions of the tracepoint macros that do the sampling outside
>> the lock, but that wasn't deemed acceptable for whatever reason.
>> I don't even know why the current macros are doing the
>> sampling while holding the lock...
> 
> Any objections to me sending the batch and we figure out later how get
> the tracepoints for i915 enabled again on RT?
> It would be an improvement because you could take a vanilla kernel and
> enable PREEMPT_RT and you would only miss the tracepoints while now you
> can't enable i915 at all and XE either doesn't compile or spills
> warnings at runtime due to the code it shares with i915.
> 
> Sebastian

FWIW, I did some quick testing. There should be no need for disabling tracepoints on xe.
The uncore lock is for a very specific reason (intel_de.h):
 * Certain architectures will die if the same cacheline is concurrently accessed
 * by different clients (e.g. on Ivybridge). Access to registers should
 * therefore generally be serialised, by either the dev_priv->uncore.lock or
 * a more localised lock guarding all access to that bank of registers.

Since we only support modern platforms on xe there is no need for the uncore lock and the specific error will not trigger.
On xe, it only exists to be used in vblank evasion for compatiblity with i915.

From the xe point of view, I would say applying patch 1-3 is sufficient.
Patch 3 because i915_utils.h is used by display still, unfortunately..

I would recommend adjusting the patch to keep the display tracepoints enabled on xe,
the non-vblank i915-specific patches should be harmless to apply.

After that, the rest can be applied too.

While I understand the theoretical need for more testing, I think we should go for practical and apply
patch 1-2 too. Even on normal kernels there is absolutely no guarantee of fast completion.
I'd say on a deterministic -rt kernel, I'd say it's less likely that vblank evasion is a problem.

Kind regards,
~Maarten


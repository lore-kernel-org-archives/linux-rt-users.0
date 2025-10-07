Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05E2E7F29
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855402; cv=none; b=t+TAG1xTsI60QsKCIeSoGzKlZGn2xwL5xB/XnuFZ9pejroFtWB/ZvXa2Hq8HfR6WQSJMNgdOxLEcV1PdIguJpxqobvijaqGbcNl6dv85146dLYfZAphp8orxhQYRJlLYfII+PRFCMqa6865xb+jqHAPjKPQN0tlBmP75ZlM4ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855402; c=relaxed/simple;
	bh=oUheLXTOPatm7OT807f944Pcbl9JF1N3f8M/QYfSZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoFRG98haPyXuR7xTVGy/unuDdUMq5hRYmTt0qZhtlaRrVnisgC3EKsoz71ftccqd619jIB88RDv45x2GFs3KYTaX6DG6guplEA0U0DocXqh73yv+HC1k7KsLAQU5xIjcdrTNwmLkYlIhMfySlOVHK/djSOKeLUkw999YUHXZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjzB8uL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjzB8uL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC3C4CEF1;
	Tue,  7 Oct 2025 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759855402;
	bh=oUheLXTOPatm7OT807f944Pcbl9JF1N3f8M/QYfSZfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjzB8uL9JZQss0wVVoL14wN1wNlGM76vKEUiOT9pN5M2k1xfeJcZUDXu4lI4OxMRm
	 BG4RCJOeKX1sTUddoQhpAtbIngReI+JQbAJZfha9uoQYOEi70Vxnx5lcmcVrEUwts0
	 /ybIHbmJNMjVgwxkM5kfPnCMYlbejOXYGUvtvbuI2tp5GbhL0Sn2dqlkGUP9E7QMyN
	 xvF2q9it4A2zT7WJAUhfe8cXlakF+p5HTBPMEi+dtHf3Fm2+c/5gDMBBqY4K8b8fA3
	 UDCvtrmKTQuYgWDd3Psvb1KA/iWVL1eqa9EdUeD5dd3DT90RadV+oKmGiDC30sBvPQ
	 dxNqxweMFGblA==
Date: Tue, 7 Oct 2025 11:43:20 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Derek Barbosa <debarbos@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <aOVDKBNshnt9wDzz@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002205515.1299816-3-debarbos@redhat.com>

On Thu, Oct 02, 2025 at 04:55:14PM -0400, Derek Barbosa wrote:
> In the sched_debug backend code, we conditionally parse the running
> tasks block of the sched_debug file to support the older task format (as
> denoted by OLD_TASK_FORMAT).
> 
> This task format is only present on legacy 3.X kernels. However, on said
> legacy kernels, the current Makefile directives and #if macros in the
> stalld.c code do not fully support compilation of stalld.
> 
> Add a LEGACY check to the makefile, which parses `uname -r` output for
> the major kernel version, and adds a LEGACY compilation flag to the
> CFLAGS. Use the compilation flag to default to sched_debug_backend in
> the stalld.c file to avoid missing references to the queue_track code.
> 
> Also, disable Intel CET -fcf-protection and BPF support, remove
> annocheck targets, and default to the c99 compiler (if present).
> 
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>

Thanks for the fixes!
Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

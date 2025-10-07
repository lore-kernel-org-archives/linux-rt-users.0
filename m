Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F801862A
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Oct 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855338; cv=none; b=VGbdpiJhY5Pv+lMmtY/5cdwqRV7DlhsqoWOHHLGz0oJKYEs4/XKIg1VAQQqq8TusGK+fsVVV+fEAj+/7xTIUboxCmVLlx7FnmtpZ4SRXcLNpjJgK5maW37u1Y5qXzKDYVlz/5R7wrEKgvUSQZHPwv8vSZ++4zwwOpyJHemCcL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855338; c=relaxed/simple;
	bh=aJ9YfC34nqmO+q7LOCVeufybbHpSWtmSLDOVWrTVQcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIOqNKsfk0fox0+9JF7IrH22OFAdY6sM2aTLetJU/6QH1PIU+2eCqHy5jpZ1vRmfFhzfDGtG67IKHWj8xOF0nS/cnv3Li2+Hmdw966umj8okMgKci/M3J6rcprQj+uuExMdbAkV1Pxkk4Y1L/OPonboR7aU3uuBQg1el58feF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEy52Qj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEy52Qj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BCDC4CEF1;
	Tue,  7 Oct 2025 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759855338;
	bh=aJ9YfC34nqmO+q7LOCVeufybbHpSWtmSLDOVWrTVQcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEy52Qj0VJD7i3mLTeuDlX+BMCth1z0dZrXnfefUvtgVgx6zbd5S2xp1FGPj7gv0U
	 rTXv08uXeaQzijDAFMTiMoO3U1+tSQ9u8i16Yrofj9T9My+2Tad5syt/fF2SssYlUR
	 T8SfTjQCW+k4xKiZKFlUdAMZetLpWY92pNOu7gJa1v+v2Y91uAuVqeIjWFaB65JXvf
	 jAteNnQqkv+08xYDI9iezG2FqqfA5qhEuQqSFJCFouv+lYNZ5J7L+Gddq3CGlpcAFY
	 Y+1u/a7jW0SfvD99zHFzAJ8vuTGBOhMaJYjl99X2b98Xzu8pivNLomfpuow+R5a0nG
	 4JXStrJo9YUrQ==
Date: Tue, 7 Oct 2025 11:42:16 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Derek Barbosa <debarbos@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/3] scripts: fix run-local if bashism
Message-ID: <aOVC6GuIaVQ3kyZb@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-4-debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002205515.1299816-4-debarbos@redhat.com>

On Thu, Oct 02, 2025 at 04:55:15PM -0400, Derek Barbosa wrote:
> In older versions of Bash, mainly 4.2.X, a semicolon (or newline) is
> requied after a conditional statement and before the `then` keyword.
> 
> Add the semicolon to allow testing and quick "local runs" on legacy
> kernels.
> 
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>

Thank you
-- 
The United States Coast Guard
Ruining Natural Selection since 1790

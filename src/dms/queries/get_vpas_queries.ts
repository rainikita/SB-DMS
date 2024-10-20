import { Injectable } from '@nestjs/common';

@Injectable()
export class VpasQueryService {
  constructor() {}

public async getVpas() {
    const queryStr = `
    SELECT *
    FROM dmsr.vpa
  `;
    return queryStr;
  }

  // Query to fetch the list of VPAs based on status
//   public async getVpasByVid() {
//     const queryStr = `
//       SELECT *
//       FROM dmsr.vpas
//       WHERE vid = $1;
//     `;
//     return queryStr;
//   }

}

module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :rekap do
      desc "Return all Rekapitulasi Hasil PilPres 2014"
      get do
        rekaps = Array.new

        # Prepare conditions based on params
        valid_params = {
          urut: 'urut',
          provinsi: 'provinsi_id'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        Rekap.includes(:province)
          .where(conditions)
          .order("provinsi_id")
          .each do |rekap|
            rekaps << {
              provinsi: {
                id: rekap.province_id,
                nama: rekap.province_nama_lengkap
              },
              urut: rekap.urut,
              pasangan: rekap.pasangan,
              jumlah_suara: rekap.jumlah_suara,
              presentase: rekap.presentase
            }
          end

        {
          results: {
            count: rekaps.count,
            rekapitulasi: rekaps
          }
        }
      end
    end
  end
end